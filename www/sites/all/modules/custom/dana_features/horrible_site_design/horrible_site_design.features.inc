<?php
/**
 * @file
 * horrible_site_design.features.inc
 */

/**
 * Implements hook_node_info().
 */
function horrible_site_design_node_info() {
  $items = array(
    'horrible_site_design' => array(
      'name' => t('Horrible Site Design'),
      'base' => 'node_content',
      'description' => '',
      'has_title' => '1',
      'title_label' => t('Title'),
      'help' => '',
    ),
  );
  return $items;
}
