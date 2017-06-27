/**
 * Created by Peter on 6/1/17.
 */

const ArtistSearchNavBarComponent = props => {

    return(
        <div>
            <i className="material-icons md-dark search-icon" id="search-icon">search</i>
            <input type="text" name="search" className="search-box my-auto" placeholder="Search Artist" onChange={props.searchPath} onKeyDown={function(e){if(e.keyCode == 13){props.submitSearch()}}}/>
        </div>

    );
};
