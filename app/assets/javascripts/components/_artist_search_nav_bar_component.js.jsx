/**
 * Created by Peter on 6/1/17.
 */

const ArtistSearchNavBarComponent = props => {

    return(
        <input type="text" name="search" className="search-box" placeholder="Search Artist" onChange={props.searchPath} onKeyDown={function(e){if(e.keyCode == 13){props.submitSearch()}}}/>
    );
};
