const ArtistsComponent = props => {
    const showArtists = (artist) => {
        let url = "/users/"+artist.id;
        let image_url;
        if(artist.picture.url != null && artist.picture.url != ""){
            image_url = "http://res.cloudinary.com/mybandsource/image/upload/v1/ " + artist.picture.url;
        }
        else{
            image_url = "http://res.cloudinary.com/mybandsource/image/upload/v1/static/blank_user";
        }
        return(
            <div key={artist.id}>
                <img src={image_url} height="30" width="40" alt="" />
                <a href={url}>{artist.name}</a>
            </div>
        )
    };

    return (
        <ul className="live-search-results">
            {props.showButton == false ? (
                    <div>
                        <a href="javascript:;" onClick={props.submitSearch} >Search for "{props.entry}"</a>
                    </div>
                ) : null
            }
            {props.artists.map(showArtists)}
        </ul>
    );
};