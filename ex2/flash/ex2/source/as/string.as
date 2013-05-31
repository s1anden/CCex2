//---------------------------------------------------------------------------
// String object rewrite v1.5
//	Branden J. Hall
//	Fig Leaf Software
//
//	Thanks to Damien Morton for the indexOf code
//	Thanks to Steven Yi for the *great* idea for the split code
//	Thanks to Dave@opaque.net for an additional speed boost to split
//	Thanks to Jobe Makar for spotting a bug in split	
//---------------------------------------------------------------------------
String.prototype.charAt = function(index){
	return(substring(this, index+1, 1));
}

String.prototype.concat = function(){
	var r = this.toString();
	for (var i=0; i<arguments.length; ++i){
		r += arguments[i];
	}
	return (r);
}

String.prototype.indexOf = function(sub, i){
 	if (i == null) i = 0;
 	var size = sub.length;
 	var last = this.length - size + 1;
 	while ((i <= last) && (substring(this, 1+i++, size) != sub));
	return (i <= last ? (i-1) : -1);
}

String.prototype.lastIndexOf = function(sub, i){
	size = sub.length;
	i == null ? i = this.length - size + 1 : ++i;
	if (sub.length == 0) return i-1;
	while ((i >= 0) && (substring(this, i--, size) != sub));
	return (i == -1 ? -1 : (i));
}

String.prototype.slice = function(s, e){
	return(substring(this, s+1, e-s));
}

String.prototype.split = function(d){
	if (d != null){
		var r = new Array();
		var size = this.length;
		var c = 0;
		var n = 0;
		if (d != ""){
			for (var i=0; i<=size; ++i){
				if (substring(this, i+1, 1) == d){
					r[n] = substring(this, c+1, i-c);
					c = i+1;
					++n;
				}
			}
			if (c != i){
				r[n] = substring(this, c+1, i-c);
			}
		}else{
			for (var i=0; i<size; ++i){
					r[i] = substring(this, i+1, 1);
			}		
		}
	}else{
		r = new Array(this.toString());
	}
	return (r);
}

String.prototype.substr = function(s, l){
	if (s < 0) s += this.length;
	if (l == null){
		l = this.length - s;
	}
	return(substring(this, s+1, l));
}
//---------------------------------------------------------------------------
