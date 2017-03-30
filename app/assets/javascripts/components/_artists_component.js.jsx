const ArtistsComponent = props => {
    const showArtists = (artist) => {
        let url = "/artists/"+artist.id;
        return(
            <div key={artist.id} className="search_result">
                <a href={url}>{artist.name}</a>
            </div>
        )
    };

    return (
        <ul>{props.artists.map(showArtists)}</ul>
    );
};