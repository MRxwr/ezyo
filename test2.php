<?php
var_dump($html = file_get_contents("https://ww.tuktukcima.com/%D8%A7%D9%86%D9%85%D9%8A-%D8%A7%D9%84%D9%85%D8%AD%D9%82%D9%82-%D9%83%D9%88%D9%86%D8%A7%D9%86-detective-conan-%D8%A7%D9%84%D8%AD%D9%84%D9%82%D8%A9-1100-%D9%85%D8%AA%D8%B1%D8%AC%D9%85%D8%A9/watch/"));

// Create a DOMDocument with specified character encoding
$dom = new DOMDocument('1.0', 'UTF-8');
@$dom->loadHTML('<?xml encoding="UTF-8">' . $html);

// Create a DOMXPath object
$xpath = new DOMXPath($dom);

// Query the HTML to extract data
$watchLinks = $xpath->query('//div[@class="watch--servers--list"]/ul/li/@data-link');
$downloadLinks = $xpath->query('//div[@class="downloads"]/a/@href');

// Check if links are found
if ($watchLinks->length > 0 || $downloadLinks->length > 0) {
    $data = [
        'watch' => [],
        'download' => []
    ];

    // Loop through each watch link
    foreach ($watchLinks as $watchLink) {
        $data['watch'][] = $watchLink->nodeValue;
    }

    // Loop through each download link
    foreach ($downloadLinks as $downloadLink) {
        $data['download'][] = $downloadLink->nodeValue;
    }

    // Output the JSON array
    echo json_encode($data, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
} else {
    echo 'Error: Links not found.';
}