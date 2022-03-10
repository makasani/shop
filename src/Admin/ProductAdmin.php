<?php

declare(strict_types=1);

namespace App\Admin;

use App\Entity\ProductImage;
use Doctrine\DBAL\Types\TextType;
use Sonata\AdminBundle\Admin\AbstractAdmin;
use Sonata\AdminBundle\Datagrid\DatagridMapper;
use Sonata\AdminBundle\Datagrid\ListMapper;
use Sonata\AdminBundle\FieldDescription\FieldDescriptionInterface;
use Sonata\AdminBundle\Form\FormMapper;
use Sonata\AdminBundle\Show\ShowMapper;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\DomCrawler\Image;
use Symfony\Component\Form\Extension\Core\Type\FileType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;

final class ProductAdmin extends AbstractAdmin
{
    public function __construct($code, $class, $baseControllerName, $entityManager)
    {
        parent::__construct($code, $class, $baseControllerName);
        $this->entityManager = $entityManager;
    }

    protected function configureDatagridFilters(DatagridMapper $filter): void
    {
        $filter
            ->add('title')
            ->add('description')
            ->add('isActive')
            ->add('rate')
            ->add('price')
        ;
    }

    protected function configureListFields(ListMapper $list): void
    {
        $list
            ->add('title')
            ->add('description', TextareaType::class)
            ->add('category')
            ->add('createdAt')
            ->add('updatedAt')
            ->add('rate')
            ->add('price')
            ->add('isActive')
            ->add(ListMapper::NAME_ACTIONS, null, [
                'actions' => [
                    'show' => [],
                    'edit' => [],
                    'delete' => [],
                ],
            ]);
    }

    protected function configureFormFields(FormMapper $form): void
    {
        $form
            ->add('title')
            ->add('description')
            ->add('category')
            ->add('rate')
            ->add('price')
            ->add('isActive')
            ->add('newImage', FileType::class, [
                'required' => false,
                'mapped' => false,
            ])
        ;
    }

    protected function configureShowFields(ShowMapper $show): void
    {
        $show
//            ->add('productImages', EntityType::class, [
//                'label' => 'User',
//                'class' => ProductImage::class,
//                'required' => true,
//                'choice_label' => function (ProductImage $productImage) {
//                    return sprintf(
//                        '#%s',
//                        $productImage->getFilepath(),
//                    );
//                },
//            ])
            ->add('productImages')
            ->add('title')
            ->add('description')
            ->add('category')
            ->add('rate')
            ->add('price')
            ->add('createdAt')
            ->add('updatedAt')
            ->add('isActive')
        ;
    }

    public function preUpdate(object $object): void
    {
        $fileInfo = $this->getForm()->get('newImage')->getData();

        if ($fileInfo) {

            $safeFilename = 'product';
            $newFilename = $safeFilename . '-' . uniqid() . '.' . $fileInfo->guessExtension();

            $productImage = new ProductImage();
            $productImage->setProduct($this->getForm()->getData());
            $productImage->setFilepath($newFilename);

            $productId = $productImage->getProduct()->getId();

            try {
                $fileInfo->move(
                    'product-images/'.$productId.'/',
                    $newFilename
                );
                $this->getModelManager()->update($productImage);

            } catch (FileException $e) {
                // ... handle exception if something happens during file upload
            }
        }

    }
}
