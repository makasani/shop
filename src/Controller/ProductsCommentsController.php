<?php

namespace App\Controller;

use App\Entity\ProductsComments;
use App\Entity\User;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use App\Form\ProductsCommentsFormType;

class ProductsCommentsController extends AbstractController
{
    /**
     * @Route("/comment_form", name="app_comment_form", methods={"GET", "POST"})
     */
    public function create(Request $request, $productId, EntityManagerInterface $entityManager): Response
    {
        //TODO Разобраться почему данные из формы не передаются если используется render(controller
//        $productsComments = new ProductsComments();
//
//        $form = $this->createForm(ProductsCommentsFormType::class, $productsComments);
//        $form->handleRequest($request);
//
//        $user = $this->get('security.token_storage')->getToken()->getUser();
//        $productsComments->setUser($user);
//
//        $product = $entityManager->getRepository("App:Product")->findBy(['id' => $productId]);
//        $productsComments->setProduct($product[0]);
//
//        $data = $form->getData();
//
//        #if ($form->isSubmitted() && $form->isValid()) {
//        if ($form->isSubmitted()) {
//            dd($data, $productsComments);
//            $entityManager = $this->getDoctrine()->getManager();
//            $entityManager->persist($productsComments);
//            $entityManager->flush();
//
//            return $this->redirectToRoute('app_index');
//        }
//
//        return $this->render('app/forms/products_comments.html.twig', [
//            'productsCommentsForm' => $form->createView(),
//            'productId' => $productId,
//        ]);
        return $this->redirectToRoute('app_index');
    }

    /**
     * @Route("/comments_show", name="app_comments_show", methods={"GET", "POST"})
     */
    public function show(int $productId, EntityManagerInterface $entityManager): Response
    {
        $comments = $entityManager->getRepository("App:ProductsComments")->findBy(['product' => $productId], ['createdAt' => 'DESC']);

        return $this->render('app/_embed/_comments.html.twig', [
            'comments' => $comments,
        ]);
    }
}
