<?php

$curl = curl_init();
curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://ww.tuktukcima.com/wp-content/themes/Elshaikh/Inc/Ajax/Searching.php',
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

// Create a DOMDocument
$dom = new DOMDocument();
@$dom->loadHTML($html);

// Create a DOMXPath object
$xpath = new DOMXPath($dom);

// Query the HTML to extract data
$item = $xpath->query('//li/a')->item(0);

// Check if an item is found
if ($item) {
    $jsonData = [
        'item' => [
            'href' => $item->getAttribute('href'),
            'icon' => $xpath->evaluate('string(i/@class)', $item),
            'text' => $xpath->evaluate('string(span)', $item),
        ]
    ];

    // Output the JSON
    echo json_encode($jsonData, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
} else {
    echo 'Error: Item not found.';
}