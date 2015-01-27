$( initialize );

function initialize() {
    $( '#tag-search' ).autocomplete({
        source: function( request, response ) {
            $.ajax({
                url: "/tags.json",
                data: { q: request.term },
                success: function( data ) {
                    response( $.map( data, function( item ) {
                        console.log( item );
                        return {
                            label: item.attributes.label,
                            tag_id: item.attributes.id
                        }
                    }));
                }
            })
        },
        minLength: 2,
        select: function( event, ui ) {
            add_tag( ui.item.tag_id );
        }
    });
}

function add_tag( tag )
{
    var video = $( "#video_id" ).val();
    var url   = "/videos/" + video + "/tags/" + tag;

    $.post( url, function( doc, text_status ) {
        window.location.reload( true );
    })
}