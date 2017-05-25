const ArtistsComponent = props => {
    const showArtists = (artist) => {
        let url = "/artists/"+artist.id;
        return(
            <div key={artist.id}>
                <img src={artist.picture} height="30" width="40" alt="Avatar" />
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