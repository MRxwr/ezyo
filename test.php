<?php

$curl = curl_init();
curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://egydead.space/wp-content/themes/egydeadc-taq/Ajax/live-search.php',
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
var_dump($html = $response);

// Create a DOMDocument
$dom = new DOMDocument();
@$dom->loadHTML($html);

// Create a DOMXPath object
$xpath = new DOMXPath($dom);

// Query the HTML to extract data
$liveItems = $xpath->query('//div[@class="liveItem"]');
$data = [];

// Loop through each liveItem
foreach ($liveItems as $liveItem) {
    $jsonData = [
        'liveItem' => [
            'href' => $xpath->evaluate('string(a/@href)', $liveItem),
            'imgSrc' => $xpath->evaluate('string(a/img/@src)', $liveItem),
            'title' => $xpath->evaluate('string(a/h3)', $liveItem),
        ]
    ];

    // Add the JSON data to the array
    $data[] = $jsonData;
}

// Output the JSON array
echo json_encode($data, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
