<?php
    $curl = curl_init();
    curl_setopt_array($curl, array(
    CURLOPT_URL => 'https://www.youtube.com/',
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_ENCODING => '',
    CURLOPT_MAXREDIRS => 10,
    CURLOPT_TIMEOUT => 0,
    CURLOPT_FOLLOWLOCATION => true,
    CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
    CURLOPT_CUSTOMREQUEST => 'GET',
    ));
    var_dump($response = curl_exec($curl));
    curl_close($curl);
$html = $response;

// Create a DOMDocument with specified character encoding
$dom = new DOMDocument('1.0', 'UTF-8');
@$dom->loadHTML('<?xml encoding="UTF-8">' . $html);

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
$jsonData = json_encode($data, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);

// Output the JSON
echo $jsonData;
