<?php

namespace App\Service;

use App\Repository\CategoryRepository;

class SidebarNavigatorService
{
    private CategoryRepository $categoryRepository;

    public function __construct(
        CategoryRepository $categoryRepository
    ) {
        $this->categoryRepository = $categoryRepository;
        return $this;
    }

    public function getNavbarCategory($categoryId = null): array
    {
        $categories = $this->categoryRepository->findBy(['parent' => null]);
        dump($categories);
        return [];
    }
}
