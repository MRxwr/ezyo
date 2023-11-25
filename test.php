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

// Create a DOMDocument with specified character encoding
$dom = new DOMDocument('1.0', 'UTF-8');
@$dom->loadHTML('<?xml encoding="UTF-8">' . $html);

// Create a DOMXPath object
$xpath = new DOMXPath($dom);

// Query the HTML to extract data
$items = $xpath->query('//ul/li/a');

// Check if items are found
if ($items->length > 0) {
    $data = [];

    // Loop through each item
    foreach ($items as $item) {
        $jsonData = [
            'item' => [
                'href' => $item->getAttribute('href'),
                'icon' => $xpath->evaluate('string(i/@class)', $item),
                'text' => $xpath->evaluate('string(span)', $item),
            ]
        ];

        // Add the JSON data to the array
        $data[] = $jsonData;
    }

    // Output the JSON array
    echo json_encode($data, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
} else {
    echo 'Error: Items not found.';
}