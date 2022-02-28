<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class CategoryController extends AbstractController
{
    /**
     * @Route("/category", name="app_category")
     */
    public function category(): Response
    {
        //TODO Вывести информации о категориях в шаблон twig.html
        return $this->render('main/category.html.twig', [
            'controller_name' => 'CategoryController',
            'categories' => 'categories array',
        ]);
    }
}
