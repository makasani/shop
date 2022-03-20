<?php

namespace App\Storage;

use App\Entity\Order;
use App\Repository\OrderRepository;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\RequestStack;
use Symfony\Component\HttpFoundation\Session\SessionInterface;



/**
 * Class CartSessionStorage
 * @package App\Storage
 */
/**
 * Class CartSessionStorage
 * @package App\Storage
 */
class CartSessionStorage
{
    /**
     * @var SessionInterface
     */
    private $interface;

    /**
     * The cart repository.
     *
     * @var OrderRepository
     */
    private $cartRepository;

    /**
     * @var string
     */
    const CART_KEY_NAME = 'cart_id';

    /**
     * CartSessionStorage constructor.
     *
     * @param SessionInterface $interface
     * @param OrderRepository $cartRepository
     */
    public function __construct(SessionInterface $interface, OrderRepository $cartRepository)
    {
        $this->interface = $interface;
        $this->cartRepository = $cartRepository;
    }

    /**
     * Gets the cart in session.
     *
     * @return Order|null
     */
    public function getCart(): ?Order
    {
        return $this->cartRepository->findOneBy([
            'id' => $this->getCartId(),
            'status' => Order::STATUS_CART
        ]);
    }

    /**
     * Sets the cart in session.
     *
     * @param Order $cart
     */
    public function setCart(Order $cart): void
    {
        $this->interface->set(self::CART_KEY_NAME, $cart->getId());
    }

    /**
     * Returns the cart id.
     *
     * @return int|null
     */
    public function getCartId(): ?int
    {
        return $this->interface->get(self::CART_KEY_NAME);

    }
}
