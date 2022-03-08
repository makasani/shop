<?php

namespace App\Command;

use App\Entity\User;
use App\Repository\UserRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Exception\RuntimeException;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Question\Question;
use Symfony\Component\Console\Style\SymfonyStyle;
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;
use Symfony\Component\Stopwatch\Stopwatch;

class AddUserCommand extends Command
{
    protected static $defaultName = 'app:add-user';
    protected static $defaultDescription = 'Создание пользователя';

    /**
     * @var EntityManagerInterface
     */
    private $entityManager;

    /**
     * @var UserPasswordEncoderInterface
     */
    private $encoder;

    /**
     * @var UserRepository
     */
    private $userRepository;

    /**
     * @param string|null $name
     * @param EntityManagerInterface $entityManager
     * @param UserPasswordEncoderInterface $encoder
     * @param UserRepository $userRepository
     */
    public function __construct(string $name = null,
                                EntityManagerInterface $entityManager,
                                UserPasswordEncoderInterface $encoder,
                                UserRepository $userRepository)
    {
        parent::__construct($name);
        $this->entityManager  = $entityManager;
        $this->encoder        = $encoder;
        $this->userRepository = $userRepository;
    }

    protected function configure(): void
    {
        $this
            ->setDescription(self::$defaultDescription)
            ->addOption('name', 'nme', InputArgument::REQUIRED, 'Введите имя')
            ->addOption('email', 'eml',InputArgument::REQUIRED, 'Введите email')
            ->addOption('password', 'psw',InputArgument::REQUIRED, 'Введите пароль')
            ->addOption('role', 'rl',InputArgument::OPTIONAL, 'Роль', false)
        ;
    }

    /**
     * @param InputInterface $input
     * @param OutputInterface $output
     * @return int
     */
    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        $io = new SymfonyStyle($input, $output);

        $stopwatch = new Stopwatch();
        $stopwatch->start('add-user-command');

        $name = $input->getOption('name');
        $email = $input->getOption('email');
        $password = $input->getOption('password');
        $role = $input->getOption('role');

        $io->title('Добавление пользователя');
        $io->text([
            'Пожалуйста, введите необходимые данные'
        ]);

        if (!$name) {
            $name = $io->ask('Введите имя');
        }

        if (!$email) {
            $email = $io->ask('Введите email');
        }

        if (!$password) {
            $password = $io->askHidden('Введите пароль (при заполнении невидно)');
        }

        if (!$role) {
            $question = new Question("Введите 1 для роли \"ROLE_ADMIN\"", "0");
            $role = $io->askQuestion($question);
        }

        if (!$role) {
            $role = 0;
        }

        try {
            $user = $this->createUser($name, $email, $password, $role);
        } catch (RuntimeException $exception) {
            $io->comment($exception->getMessage());

            return -1;
        }

        $successMessage = sprintf('Был зарегистрирован пользователь: %s',
            $role === '1' ?
                "администратор"
                :
                "простой пользователь");

        $io->success($successMessage);

        $event = $stopwatch->stop('add-user-command');
        $stopwatchMessage = sprintf('ID ползователя: %s / Время работы скрипта: %.2f ms / Затрачено памяти: %.2f MB',
            $user->getId(),
            $event->getDuration(),
            $event->getMemory() / 1000 / 1000
        );
        $io->comment($stopwatchMessage);

        return 0;
    }

    /**
     * @param string $name
     * @param string $email
     * @param string $password
     * @param string $role
     * @return User
     */
    private function createUser(string $name, string $email, string $password, string $role): User
    {
        $existingUser = $this->userRepository->findOneBy(['email' => $email]);

        if ($existingUser) {
            throw new RuntimeException('Пользователь уже существует!');
        }

        $roles[] = $role === "0" ? "ROLE_USER" : "ROLE_ADMIN";

        $user = new User();
        $user->setName($name);
        $user->setEmail($email);
        $user->setRoles($roles);

        $encodedPassword = $this->encoder->encodePassword($user, $password);
        $user->setPassword($encodedPassword);

        $this->entityManager->persist($user);
        $this->entityManager->flush();

        return $user;
    }
}
