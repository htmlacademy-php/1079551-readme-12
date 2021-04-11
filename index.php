<?php
require_once 'helpers.php';

$isAuth = rand(0, 1);
$titleName = 'readme: популярное';

$userName = 'Chetin Vitalii'; // укажите здесь ваше имя
$postCards = [
    [
        'heading' => 'Цитата',
        'type' => 'post-quote',
        'content' => 'Мы в жизни любим только раз, а после ищем лишь похожих',
        'user_name' => 'Лариса',
        'avatar' => 'userpic-larisa-small.jpg'
    ],
    [
        'heading' => 'Игра престолов',
        'type' => 'post-text',
        'content' => 'Действие «Игры престолов» происходит в вымышленном мире, напоминающем средневековую Европу. В сериале одновременно действует множество персонажей и развивается несколько сюжетных линий. Основных сюжетных арок три: первая посвящена борьбе нескольких влиятельных домов за Железный Трон Семи Королевств либо за независимость от него; вторая — потомку свергнутой династии правителей, принцессе-изгнаннице, планирующей вернуть престол; третья — древнему братству, охраняющему государство от угроз с севера .',
        'user_name' => 'Владик',
        'avatar' => 'userpic.jpg'
    ],
    [
        'heading' => 'Наконец, обработал фотки!',
        'type' => 'post-photo',
        'content' => 'rock-medium.jpg',
        'user_name' => 'Виктор',
        'avatar' => 'userpic-mark.jpg'
    ],
    [
        'heading' => 'Моя мечта',
        'type' => 'post-photo',
        'content' => 'coast-medium.jpg',
        'user_name' => 'Лариса',
        'avatar' => 'userpic-larisa-small.jpg'
    ],
    [
        'heading' => 'Лучшие курсы',
        'type' => 'post-link',
        'content' => 'www.htmlacademy.ru',
        'user_name' => 'Владик',
        'avatar' => 'userpic.jpg'
    ]
];

function cutText(string $textForCut, int $maxResultLenght = 300): string {
    /* считаю кол-во символов в строке */
    $totalWordLength = mb_strlen($textForCut, 'utf8');

    if ($totalWordLength <= $maxResultLenght) {
        return '<p>'.$textForCut.'</p>';
    } else {
        $wordsArray = explode(' ', $textForCut);
        $totalWordLength = 0;
        $resultString = '';
        $wordsResultArray = [];
        foreach ($wordsArray as $word) {           
            if ($totalWordLength > $maxResultLenght) {
                $resultString = implode(' ', $wordsResultArray);
                $resultString = '<p>'.$resultString.'... </p><a class="post-text__more-link" href="#">Читать далее</a>';
                break;
            };
            $totalWordLength += mb_strlen($word, 'utf8');
            $wordsResultArray[] = $word;
        };
        return $resultString;
    };
};

$pageContent = include_template('main.php', ['postCards' => $postCards]);
$layoutContent = include_template('layout.php', ['content' => $pageContent , 'titleName' => $titleName, 'isAuth' => $isAuth, 'userName' => $userName]);

print($layoutContent);

?>

