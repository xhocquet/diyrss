import Draggabilly from "draggabilly"
import Packery from "packery"

Packery.prototype.getShiftPositions = function( attrName ) {
  attrName = attrName || 'id';
  var _this = this;
  return this.items.map( function( item ) {
    return {
      attr: item.element.getAttribute( attrName ),
      x: item.rect.x / _this.packer.width
    }
  });
};

Packery.prototype.initShiftLayout = function( positions, attr ) {
  if ( !positions ) {
    // if no initial positions, run packery layout
    this.layout();
    return;
  }
  // parse string to JSON
  if ( typeof positions == 'string' ) {
    try {
      positions = JSON.parse( positions );
    } catch( error ) {
      console.error( 'JSON parse error: ' + error );
      this.layout();
      return;
    }
  }

  attr = attr || 'id'; // default to id attribute
  this._resetLayout();
  // set item order and horizontal position from saved positions
  this.items = positions.map( function( itemPosition ) {
    var selector = '[' + attr + '="' + itemPosition.attr  + '"]'
    var itemElem = this.element.querySelector( selector );
    var item = this.getItem( itemElem );
    item.rect.x = itemPosition.x * this.packer.width;
    return item;
  }, this );
  this.shiftLayout();
};

export default function setupContainerAndSaving(argument) {
  var colWidth = null
  var containerWidth = $('.categories-container').width()

  if (containerWidth > 1000) {
    colWidth = containerWidth / 100 * 23
  }
  else if (containerWidth > 600) {
    colWidth = containerWidth / 100 * 31
  }
  else {
    colWidth = containerWidth / 100 * 48
  }

  // Draggable grid
  var $grid = $('.categories-container').packery({
    itemSelector: '.category-container',
    gutter: 10,
    columnWidth: colWidth,
    percentPosition: true,
    initLayout: false // disable initial layout
  });

  // get saved dragged positions
  var initPositions = localStorage.getItem('dragPositions');
  // init layout with saved positions
  $grid.packery( 'initShiftLayout', initPositions, 'data-item-id' );

  $grid.find('.category-container').each( function( i, gridItem ) {
    var draggie = new Draggabilly( gridItem );
    $grid.packery( 'bindDraggabillyEvents', draggie );
  });

  // Saving element positions to local storage
  $grid.on( 'dragItemPositioned', function() {
    var positions = $grid.packery( 'getShiftPositions', 'data-item-id' );
    localStorage.setItem( 'dragPositions', JSON.stringify( positions ) );
  });

  $('.refresh-layout-button').click(function(e) {
    e.preventDefault();
    $grid.packery()
  })
}
