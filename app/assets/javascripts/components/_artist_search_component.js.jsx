const ArtistSearchComponent = props => {

    return(
        <div className="text-center">
            <div className="input-group input-group-lg">
                <i className="material-icons md-dark search-icon" id="search-icon">search</i>
                <input type="text" name="query" id="search-bar" className="form-control search-bar mx-auto" placeholder="Search Artist" onChange={props.searchPath} onKeyDown={function(e){if(e.keyCode == 13){props.submitSearch()}}}/>
            </div>
            {props.showButton == true ? (
                    <button onClick={props.submitSearch} className="btn btn-danger search-btn mx-auto">Search</button>
                ) : null
            }
        </div>
    );
};