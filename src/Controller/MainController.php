<?php

namespace App\Controller;

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
     * @Route("/shop", name="app_products_list")
     */
    public function productsList(): Response
    {
        return $this->render('app/shop.html.twig', [
            'controller_name' => 'MainController',
        ]);
    }

    /**
     * @Route("/product", name="app_product_show")
     */
    public function productShow(): Response
    {
        return $this->render('app/shop-single.html.twig', [
            'controller_name' => 'MainController',
        ]);
    }
}
