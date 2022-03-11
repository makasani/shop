<?php

namespace App\Controller;

use App\Entity\ProductsComments;
use App\Entity\User;
use App\Form\ProductsCommentsFormType;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class MainController extends AbstractController
{
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
     * @Route("/catalog", name="app_products_list")
     */
    public function productsList(EntityManagerInterface $entityManager): Response
    {
        $products = $entityManager->getRepository("App:Product")->findBy([],[],9);

        //TODO Страшно, ну а что поделаешь... переделаю
        foreach ($products as $product) {
            $product->imagepath = $product->getProductImagePath($entityManager);
        }

        return $this->render('app/catalog.html.twig', [
            'products' => $products,
        ]);
    }

    /**
     * @Route("/product/{id}", name="app_product_show", methods={"GET", "POST"})
     */
    public function productShow(EntityManagerInterface $entityManager, Request $request): Response
    {

        $user = $this->get('security.token_storage')->getToken()->getUser();
        $productId = $request->attributes->get('id');
        $product = $entityManager->getRepository("App:Product")->findBy(['id' => $productId]);
        $category = $entityManager->getRepository("App:Category")->findBy(['id' => $product[0]->getCategory()->getId()]);

        //TODO Страшно, ну а что поделаешь... переделаю
        $product[0]->imagepath = $product[0]->getProductImagePath($entityManager);


        if($user === "anon.") {
            return $this->render('app/shop-single.html.twig', [
                'product' => $product[0],
                'category' => $category[0],
                'productId' => $productId,
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
}
