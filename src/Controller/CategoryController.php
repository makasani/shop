<?php

namespace App\Controller;

use App\Repository\ProductRepository;
use App\Repository\CategoryRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

class CategoryController extends AbstractController
{
    private CategoryRepository $categoryRepository;
    private ProductRepository $productRepository;
    private EntityManagerInterface $entityManager;
    // private SidebarNavigatorService $sidebarNavigatorService;

    public function __construct(
        CategoryRepository $categoryRepository,
        ProductRepository $productRepository,
        EntityManagerInterface $entityManager
        // SidebarNavigatorService $sidebarNavigatorService
    ) {
        $this->categoryRepository = $categoryRepository;
        $this->productRepository = $productRepository;
        $this->entityManager = $entityManager;
        // $this->sidebarNavigatorService = $sidebarNavigatorService;
    }

    /**
     * @Route("/category", name="categoryRoot")
     */
    public function categoryRoot(): Response
    {
        // $sidebar = $this->sidebarNavigatorService->getNavbarCategory();
        $categories = $this->categoryRepository->findBy(['parent' => null]);

        $trees = $this->listToTree($this->categoryRepository->findAll());
        return $this->render('app/category.html.twig', [
            'categories' => $categories,
            'trees' => $trees,
        ]);
    }

    private function listToTree($categories, $parent = null): array
    {
        $tree = [];
        foreach ($categories as $category) {
            if ($category->getParent() == $parent) {
                $leaf = ['name' => $category->getTitle()];
                $leaf['id'] = $category->getId();
                // $leaf['rolled'] = true;
                $leaf['children'] = $this->listToTree($categories, $category);
                $tree[] = $leaf;
            }
        }
        return $tree;
    }

    public function buildFooterSidebar(): Response
    {
        $trees = $this->listToTree($this->categoryRepository->findAll());
        return $this->render('app/_embed/footer-categories.html.twig', [
            'trees' => $trees,
        ]);
    }

    public function buildSidebar(): Response
    {
        $trees = $this->listToTree($this->categoryRepository->findAll());
        return $this->render('app/_embed/_categories_sidebar.html.twig', [
            'trees' => $trees,
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
        //TODO Страшно, ну а что поделаешь... переделаю
        foreach ($products as $product) {
            $product->imagepath = $product->getProductImagePath($this->entityManager);
        }

        $trees = $this->listToTree($this->categoryRepository->findAll());

        return $this->render('app/category.html.twig', [
            'categories' => $categories,
            'products' => $products,
            'trees' => $trees,
        ]);
    }
}
