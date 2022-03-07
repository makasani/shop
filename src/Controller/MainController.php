<?php

namespace App\Controller;

use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
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

        return $this->render('app/catalog.html.twig', [
            'products' => $products,
        ]);
    }

    /**
     * @Route("/product/{id}", name="app_product_show", methods={"GET"})
     */
    public function productShow(int $id, EntityManagerInterface $entityManager): Response
    {
        $product = $entityManager->getRepository("App:Product")->findBy(['id' => $id]);
        $category = $entityManager->getRepository("App:Category")->findBy(['id' => $product[0]->getCategory()->getId()]);

        return $this->render('app/shop-single.html.twig', [
            'product' => $product[0],
            'category' => $category[0],
        ]);
    }
}
