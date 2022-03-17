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
        $breadCrumbsPath = $this->buildBreadCrumbs(null, false);
        return $this->render('app/category.html.twig', [
            'categories' => $categories,
            'trees' => $trees,
            'crumbs' => $breadCrumbsPath,
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
        $breadCrumbsPath = $this->buildBreadCrumbs($id, false);

        return $this->render('app/category.html.twig', [
            'categories' => $categories,
            'products' => $products,
            'trees' => $trees,
            'crumbs' => $breadCrumbsPath,
        ]);
    }

    public function buildBreadCrumbs(?int $parentCategoryId, bool $isLink = true): array
    {
        $categories = $this->categoryRepository->findAll();
        if (is_null($parentCategoryId)) {
            return [[
                'id' => null,
                'name' => 'Каталог',
                'child' => null,
                'isLink' => $isLink,
            ]];
        } else {
            foreach ($categories as $category) {
                if ($category->getId() == $parentCategoryId) {
                    if (is_null($category->getParent())) {
                        $parent = $this->buildBreadCrumbs(null);
                    } else {
                        $parent = $this->buildBreadCrumbs($category->getParent()->getId());
                    }
                    $parent[count($parent) - 1]['child'] = $parentCategoryId;
                    $parent[] = [
                        'id' => $parentCategoryId,
                        'name' => $category->getTitle(),
                        'child' => null,
                        'isLink' => $isLink,
                    ];
                    return $parent;
                }
            }
        }
    }
}
