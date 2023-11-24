<?php

$html = '<li class="movieItem">
    <a href="https://egydead.space/episode/%d8%a7%d9%86%d9%85%d9%8a-%d8%a7%d9%84%d9%85%d8%ad%d9%82%d9%82-%d9%83%d9%88%d9%86%d8%a7%d9%86-detective-conan-%d8%a7%d9%84%d8%ad%d9%84%d9%82%d8%a9-1078-%d9%85%d8%aa%d8%b1%d8%ac%d9%85%d8%a9/" title="انمي المحقق كونان Detective Conan الحلقة 1078 مترجمة">
        <img src="https://egydead.space/wp-content/uploads/2021/01/انمي-Detective-Conan-الحلقة-1000-217x280.jpg">
        <h1 class="BottomTitle">انمي المحقق كونان Detective Conan الحلقة 1078 مترجمة</h1>
        <span class="cat_name">مسلسلات انمي</span>
        <span class="number_episode">
            <b>حلقه</b>
            <em>1078</em>
        </span>
        <i class="fi fi-play"></i>
    </a>
</li>';

// Create a DOMDocument
$dom = new DOMDocument();
@$dom->loadHTML($html);

// Create a DOMXPath object
$xpath = new DOMXPath($dom);

// Query the HTML to extract data
$movieItems = $xpath->query('//li[@class="movieItem"]');
$data = [];

// Loop through each movie item
foreach ($movieItems as $movieItem) {
    $movie = [
        'url' => $xpath->evaluate('string(a/@href)', $movieItem),
        'title' => $xpath->evaluate('string(a/@title)', $movieItem),
        'image' => $xpath->evaluate('string(a/img/@src)', $movieItem),
        'bottomTitle' => $xpath->evaluate('string(a/h1[@class="BottomTitle"])', $movieItem),
        'category' => $xpath->evaluate('string(a/span[@class="cat_name"])', $movieItem),
        'episode' => [
            'label' => $xpath->evaluate('string(a/span[@class="number_episode"]/b)', $movieItem),
            'number' => $xpath->evaluate('string(a/span[@class="number_episode"]/em)', $movieItem),
        ],
    ];

    // Add the movie data to the array
    $data[] = $movie;
}

// Convert the array to JSON
$jsonData = json_encode($data, JSON_PRETTY_PRINT);

// Output the JSON
echo $jsonData;