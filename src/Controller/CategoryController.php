<?php

namespace App\Controller;

use App\Repository\CategoryRepository;
use App\Repository\ProductRepository;
use App\Service\SidebarNavigatorService;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class CategoryController extends AbstractController
{
    private CategoryRepository $categoryRepository;
    private ProductRepository $productRepository;
    private SidebarNavigatorService $sidebarNavigatorService;

    public function __construct(
        CategoryRepository $categoryRepository,
        ProductRepository $productRepository,
        SidebarNavigatorService $sidebarNavigatorService
    ) {
        $this->categoryRepository = $categoryRepository;
        $this->productRepository = $productRepository;
        $this->sidebarNavigatorService = $sidebarNavigatorService;
    }

    /**
     * @Route("/category", name="categoryRoot")
     */
    public function categoryRoot(): Response
    {
        // $sidebar = $this->sidebarNavigatorService->getNavbarCategory();
        $categories = $this->categoryRepository->findBy(['parent' => null]);
        //TODO Вывести информации о категориях в шаблон twig.html
        return $this->render('app/category.html.twig', [
            'categories' => $categories,
        ]);
    }

    /**
     * @Route("/category/{id}", name="categoryById")
     */
    public function categoryById(int $id): Response
    {
        // $sidebar = $this->sidebarNavigatorService->getNavbarCategory();
        $categories = $this->categoryRepository->findBy(['parent' => $id]);
        $products = $this->productRepository->findBy(['category' => $id]);
        dump($products);
        //TODO Вывести информации о категориях в шаблон twig.html
        return $this->render('app/category.html.twig', [
            'categories' => $categories,
            'products' => $products,
        ]);
    }
}
