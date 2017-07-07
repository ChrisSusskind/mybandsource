class ArtistSearchContainerComponent extends React.Component {
    constructor(props){
        super(props);
        this.state = {entry: "", artists: [], showButton: true};
        this.onChange = this.onChange.bind(this);
        this.searchArtists = $.debounce(1000, this.searchArtists.bind(this));
        this.submitSearch = this.submitSearch.bind(this);
    }

    searchArtists(e){
        if(e.target.value){
           $.ajax({
               url: this.props.searchPath+"?query="+e.target.value,
               method: 'POST',
               dataType: 'json',
               success: function(data) {
                   this.setState({artists: data});
                   this.setState({showButton: false});
               }.bind(this),
               error: function(data){
                   this.setState({artists: []});
                   this.setState({showButton: true});
               }.bind(this)
           });
        }
    }

    onChange(e){
        e.persist();
        this.setState({entry: e.target.value});
        if(e.target.value == ""){
            this.setState({artists: []});
            this.setState({showButton: true});
        }
        else{
            this.searchArtists(e);
        }
    }

    submitSearch(){
        if(this.state.entry!=""){
            $.ajax({
                url: this.props.submitPath+"?query="+this.state.entry,
                method: 'POST'
            })
        }
    }

    render(){
        if(this.props.navbar){
            return(
                <div className="react-search-container">
                    <ArtistSearchNavBarComponent searchPath={this.onChange} submitSearch={this.submitSearch} />
                    <ArtistsComponent artists={this.state.artists} showButton={this.state.showButton} entry={this.state.entry} submitSearch={this.submitSearch}/>
                </div>
            )
        }
        else {
            return(
                <div className="react-search-container">
                    <ArtistSearchComponent searchPath={this.onChange} submitSearch={this.submitSearch} showButton={this.state.showButton} />
                    <ArtistsComponent artists={this.state.artists} showButton={this.state.showButton} entry={this.state.entry} submitSearch={this.submitSearch}/>
                </div>
            );
        }
    }
}