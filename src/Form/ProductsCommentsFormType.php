<?php

namespace App\Form;

use App\Entity\ProductsComments;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Validator\Constraints\NotBlank;

class ProductsCommentsFormType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {

        $builder
            ->add('rate', IntegerType::class, [
                'label' => 'Рейтинг от 0 до 5',
                'attr' => [
                    'class' => 'form-control mt-1',
                    'autofocus' => 'autofocus',
                ],
            ])
            ->add('description', TextareaType::class, [
                'label' => 'Сообщение',
                'required' => true,
                'attr' => [
                    'class' => 'form-control mt-1',
                    'rows' => '8',
                    'autofocus' => 'autofocus',
                ],
                'constraints' => [
                    new NotBlank([
                        'message' => 'Пожалуйста, заполните поле',
                    ]),
                ],
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => ProductsComments::class,
        ]);
    }
}
