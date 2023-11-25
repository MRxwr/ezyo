<?php
$_GET["s"] = ( isset($_GET["s"]) && !empty($_GET["s"])) ? $_GET["s"] : "" ;
$curl = curl_init();
curl_setopt_array($curl, array(
  CURLOPT_URL => "https://ww.tuktukcima.com/?s={$_GET["s"]}",
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS => array('search' => 'Detective Conan'),
  CURLOPT_HTTPHEADER => array(
    'X-Requested-With: XMLHttpRequest',
    'Content-Type:multipart/form-data'
    ),
));
$response = curl_exec($curl);
curl_close($curl);
$html = $response;

// Create a DOMDocument with specified character encoding
$dom = new DOMDocument('1.0', 'UTF-8');
@$dom->loadHTML('<?xml encoding="UTF-8">' . $html);

// Create a DOMXPath object
$xpath = new DOMXPath($dom);

// Query the HTML to extract data
$items = $xpath->query('//div[@class="Block--Item"]/a');

// Check if items are found
if ($items->length > 0) {
    $data = [];

    // Loop through each item
    foreach ($items as $item) {
        // Extract genres separately within each Block--Item
        $genres = [];
        $genreNodes = $xpath->query('.//ul[@class="Genres"]/li', $item);
        foreach ($genreNodes as $genreNode) {
            $genres[] = $genreNode->nodeValue;
        }

        $jsonData = [
            'href' => $item->getAttribute('href'),
            'title' => $item->getAttribute('title'),
            'image' => $xpath->evaluate('string(div/img/@src)', $item),
            'genres' => $genres,
            'episodeTitle' => $xpath->evaluate('string(div[@class="Block--Info"]/h3)', $item),
        ];

        // Add the JSON data to the array
        $data[] = $jsonData;
    }

    // Output the JSON array
    echo json_encode($data, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
} else {
    echo 'Error: Items not found.';
}