const ArtistSearchComponent = props => {

    return(
        <div className="text-center">
            <div className="input-group input-group-lg">
                <input type="text" name="query" className="form-control search-bar" placeholder="Search for a band..." onChange={props.searchPath} onKeyDown={function(e){if(e.keyCode == 13){props.submitSearch()}}}/>
            </div>
            {props.showButton == true ? (
                    <button onClick={props.submitSearch} className="btn btn-danger button-home search-btn mx-auto m-3">Search</button>
                ) : null
            }
        </div>
    );
};