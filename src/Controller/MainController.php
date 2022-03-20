<?php

namespace App\Controller;

use App\Entity\Product;
use App\Entity\ProductsComments;
use App\Entity\User;
use App\Form\AddToCartType;
use App\Form\CartType;
use App\Form\ProductsCommentsFormType;
use App\Manager\CartManager;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class MainController extends AbstractController
{
    private CategoryController $categoryController;

    public function __construct(CategoryController $categoryController)
    {
        $this->categoryController = $categoryController;
    }

    /**
     * @Route("/", name="app_index")
     */
    public function index(): Response
    {
        return $this->render('app/index.html.twig', [
            'controller_name' => 'MainController',
        ]);
    }

    /**
     * @Route("/about", name="app_about")
     */
    public function about(): Response
    {
        return $this->render('app/about.html.twig', [
            'controller_name' => 'MainController',
        ]);
    }

    /**
     * @Route("/contact", name="app_contact")
     */
    public function contact(): Response
    {
        return $this->render('app/contact.html.twig', [
            'controller_name' => 'MainController',
        ]);
    }

    /**
     * @Route("/product/{id}", name="app_product_show", methods={"GET", "POST"})
     */
    public function productShow(EntityManagerInterface $entityManager, Request $request, Product $product, CartManager $cartManager): Response
    {

        $form = $this->createForm(AddToCartType::class);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $item = $form->getData();
            $item->setProduct($product);

            $cart = $cartManager->getCurrentCart();
            $cart
                ->addItem($item)
                ->setUpdatedAt(new \DateTime());

            $cartManager->save($cart);

            return $this->redirectToRoute('app_product_show', ['id' => $product->getId()]);
        }

        $user = $this->get('security.token_storage')->getToken()->getUser();
        $productId = $request->attributes->get('id');
        $product = $entityManager->getRepository("App:Product")->findBy(['id' => $productId]);
        $category = $entityManager->getRepository("App:Category")->findBy(['id' => $product[0]->getCategory()->getId()]);

        //TODO Страшно, ну а что поделаешь... переделаю
        $product[0]->imagepath = $product[0]->getProductImagePath($entityManager);
        $breadCrumbsPath = $this->categoryController->buildBreadCrumbs($product[0]->getCategory()->getId());

        if ($user === "anon.") {
            return $this->render('app/shop-single.html.twig', [
                'product' => $product[0],
                'category' => $category[0],
                'productId' => $productId,
                'crumbs' => $breadCrumbsPath,
                'form' => $form->createView(),
            ]);
        }

        $productsComments = new ProductsComments();

        $form = $this->createForm(ProductsCommentsFormType::class, $productsComments);
        $form->handleRequest($request);

        $productsComments->setUser($user);
        $productsComments->setProduct($product[0]);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager = $this->getDoctrine()->getManager();
            $entityManager->persist($productsComments);
            $entityManager->flush();

            return $this->redirectToRoute('app_product_show', ['id' => $productId]);
        }

        return $this->render('app/shop-single.html.twig', [
            'product' => $product[0],
            'category' => $category[0],
            'productsCommentsForm' => $form->createView(),
            'productId' => $productId,
        ]);
    }

    /**
     * @return Response
     */
    public function getUserInfo()
    {
        #$this->denyAccessUnlessGranted('IS_AUTHENTICATED_FULLY');

        /** @var User $user */
        $user = $this->getUser();

        #return new Response($user);
        return $this->render('app/_embed/_header.html.twig', [
            'user' => $user,
        ]);
    }

    /**
     * @return Response
     */
    public function getRandomProduct(int $limit, EntityManagerInterface $entityManager)
    {
        $products = $entityManager->getRepository("App:Product")->getRandomProducts(6);

        //TODO Страшно, ну а что поделаешь... переделаю
        foreach ($products as $product) {
            $product->imagepath = $product->getProductImagePath($entityManager);
        }

        #return new Response($user);
        return $this->render('app/_embed/_most_likely_products_slider.html.twig', [
            'products' => $products,
        ]);
    }

}
