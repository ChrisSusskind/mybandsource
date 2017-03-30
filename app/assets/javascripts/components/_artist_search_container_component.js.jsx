class ArtistSearchContainerComponent extends React.Component {
    constructor(props){
        super(props);
        this.state = {entry: "", artists: []};
        this.onChange = this.onChange.bind(this);
        this.searchArtists = $.throttle(1000, this.searchArtists.bind(this));
        this.submitSearch = this.submitSearch.bind(this);
    }

    searchArtists(e){
        if(e.target.value){
           $.ajax({
               url: this.props.searchPath+"?query="+e.target.value,
               method: 'POST',
               dataType: 'json',
               success: function(data) {
                   console.log(data);
                   this.setState({artists: data});
               }.bind(this),
               error: function(data){
                   this.setState({artists: []});
               }.bind(this)
           });
        }
    }

    onChange(e){
        e.persist();
        this.setState({entry: e.target.value});
        this.searchArtists(e);
    }

    submitSearch(){
        if(this.state.entry!=""){
            $.ajax({
                url: this.props.submitPath+"?query="+this.state.entry,
                method: 'POST'
            })
        }
        else{
            console.log("FUCK");
        }
    }

    render(){
        return(
            <div>
                <ArtistSearchComponent searchPath={this.onChange} submitSearch={this.submitSearch} />
                <ArtistsComponent artists={this.state.artists} />
            </div>
        );
    }
}