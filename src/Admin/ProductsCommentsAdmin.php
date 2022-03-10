<?php

declare(strict_types=1);

namespace App\Admin;

use Sonata\AdminBundle\Admin\AbstractAdmin;
use Sonata\AdminBundle\Datagrid\DatagridMapper;
use Sonata\AdminBundle\Datagrid\ListMapper;
use Sonata\AdminBundle\Form\FormMapper;
use Sonata\AdminBundle\Show\ShowMapper;

final class ProductsCommentsAdmin extends AbstractAdmin
{

    protected function configureDatagridFilters(DatagridMapper $filter): void
    {
        $filter
            ->add('user')
            ->add('description')
            ->add('rate')
            ->add('createdAt')
            ;
    }

    protected function configureListFields(ListMapper $list): void
    {
        $list
            ->add('product')
            ->add('user')
            ->add('description')
            ->add('rate')
            ->add('createdAt')
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
            ->add('product')
            ->add('user')
            ->add('description')
            ->add('rate')
            ;
    }

    protected function configureShowFields(ShowMapper $show): void
    {
        $show
            ->add('user')
            ->add('description')
            ->add('rate')
            ->add('createdAt')
            ;
    }
}
