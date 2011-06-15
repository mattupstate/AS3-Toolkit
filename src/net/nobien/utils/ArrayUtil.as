package net.nobien.utils 
{
    /**
     * The ArrayUtil class contains static utility methods for analyzing and manipulating arrays.
     */
    public class ArrayUtil
    {
        /**
         * Modifies original Array by adding all the elements from another Array at a specified position.
         * @param tarArray: Array to add elements to.
         * @param items: Array of elements to add.
         * @param index: Position where the elements should be added.
         * @return Returns {@code true} if the Array was changed as a result of the call; otherwise {@code false}.
         */
        public static function addItemsAt( tarArray:Array, items:Array, index:int = 0x7fffffff ):Boolean 
        {
            if ( items.length == 0 )
                return false;
            
            var args:Array = items.concat();
            args.splice( 0, 0, index, 0 );
            
            tarArray.splice.apply( null, args );
            
            return true;
        }
        
        /**
         * Finds out how many instances of {@code item} Array contains.
         * @param inArray: Array to search for {@code item} in.
         * @param item: Object to find.
         * @return The amount of {@code item}'s found; if none were found returns {@code 0}.
         */
        public static function contains( inArray:Array, item:* ):uint 
        {
            var i:int  = inArray.indexOf( item, 0 );
            var t:uint = 0;
            
            while ( i != -1 ) 
            {
                i = inArray.indexOf( item, i + 1 );
                t++;
            }
            
            return t;
        }
        
        /**
         * Determines if Array contains all items.
         * @param inArray: Array to search for {@code items} in.
         * @param items: Array of elements to search for.
         * @return Returns {@code true} if {@code inArray} contains all elements of {@code items}; otherwise {@code false}.
         */
        public static function containsAll(inArray:Array, items:Array):Boolean {
            var l:uint = items.length;
            
            while (l--)
                if (inArray.indexOf(items[l]) == -1)
                    return false;
            
            return true;
        }
        
        /**
         * Determines if Array {@code inArray} contains any element of Array {@code items}.
         * @param inArray: Array to search for {@code items} in.
         * @param items: Array of elements to search for.
         * @return Returns {@code true} if {@code inArray} contains any element of {@code items}; otherwise {@code false}.
         */
        public static function containsAny( inArray:Array, items:Array ):Boolean 
        {
            var l:uint = items.length;
            
            while ( l-- )
                if ( inArray.indexOf( items[l] ) != -1 )
                    return true;
            
            return false;
        }
        
        /**
         * Creates a copy of the specified array. Note that the array returned 
         * is a new array but the items within the array are not copies of the 
         * items in the original array (but rather references to the same items).
         * @param arr The array that will be copies
         * @return A new array which contains the same items as the array passed in.
         */
        public static function copyArray( arr:Array ):Array
        {	
            return arr.slice();
        }
        
        /**
         * Create a new array that only contains unique instances of objects in the specified array.
         * Basically, this can be used to remove duplication object instances from an array.
         * @param arr The array which contains the values that will be used to create the new array that contains no duplicate values.
         * @return A new array which only contains unique items from the specified array.
         */	
        public static function createUniqueCopy( a:Array ):Array
        {
            var newArray:Array = new Array();
            
            var len:Number = a.length;
            var item:Object;
            
            for ( var i:uint = 0; i < len; ++i )
            {
                item = a[i];
                
                if( ArrayUtil.contains( newArray, item ) )
                {
                    continue;
                }
                
                newArray.push( item );
            }
            
            return newArray;
        }
        
        /**
         * Compares two arrays and returns a boolean indicating whether the arrays contain the same values at the same indexes.
         * @param arr1 The first array that will be compared to the second.
         * @param arr2 The second array that will be compared to the first.
         * @return True if the arrays contains the same values at the same indexes. False if they do not.
         */		
        public static function equals(arr1:Array, arr2:Array):Boolean
        {
            if ( arr1.length != arr2.length )
            {
                return false;
            }
            
            var len:Number = arr1.length;
            
            for( var i:Number = 0; i < len; i++ )
            {
                if( arr1[i] !== arr2[i] )
                {
                    return false;
                }
            }
            
            return true;
        }
        
        /**
         * Creates new Array composed of only the non-identical elements of passed Array.
         * @param inArray: Array to remove equivalent items.
         * @return A new Array composed of only unique elements.
         * @example
         * <code>
         * var numberArray:Array = new Array(1, 2, 3, 4, 4, 4, 4, 5);
         * trace(ArrayUtil.removeDuplicates(numberArray));
         * </code>
		 */
		public static function removeDuplicates( inArray:Array ):Array 
        {
			return inArray.filter( ArrayUtil._removeDuplicatesFilter );
		}
		
		protected static function _removeDuplicatesFilter( e:*, i:int, inArray:Array ):Boolean 
        {
			return ( i == 0 ) ? true : inArray.lastIndexOf( e, i - 1 ) == -1;
		}
        
        /**
         * Modifies original Array by removing all items that are identical to the specified item.
         * @param tarArray: Array to remove passed {@code item}.
         * @param item: Element to remove.
         * @return The amount of removed elements that matched {@code item}, if none found returns {@code 0}.
         */
        public static function removeItem( tarArray:Array, item:* ):uint 
        {
            var i:int  = tarArray.indexOf( item );
            var f:uint = 0;
            
            while ( i != -1 ) 
            {
                tarArray.splice( i, 1 );
                i = tarArray.indexOf( item, i );
                f++;
            }
            
            return f;
        }
        
        /**
         * Removes only the specified items in an Array.
         * @param tarArray: Array to remove specified items from.
         * @param items: Array of elements to remove.
         * @return Returns {@code true} if the Array was changed as a result of the call; otherwise {@code false}.
         */
        public static function removeItems( tarArray:Array, items:Array ):Boolean 
        {
            var removed:Boolean = false;
            var l:uint = tarArray.length;
            
            while ( l-- ) 
            {
                if ( items.indexOf( tarArray[l] ) != -1 ) 
                {
                    tarArray.splice( l, 1 );
                    removed = true;
                }
            }
            
            return removed;
        }
        
        /**
         * Retains only the specified items in an Array.
         * @param tarArray: Array to remove non specified items from.
         * @param items: Array of elements to keep.
         * @return Returns <code>true</code> if the Array was changed as a result of the call; otherwise <code>false</code>.
         * @example
         * <code>
         * var numberArray:Array = new Array(1, 2, 3, 7, 7, 7, 4, 5);
         * ArrayUtil.retainItems(numberArray, new Array(2, 4));
         * trace(numberArray);
         * </code>
		 */
		public static function retainItems( tarArray:Array, items:Array ):Boolean 
        {
			var removed:Boolean = false;
			var l:uint = tarArray.length;
			
			while ( l-- )
            {
				if ( items.indexOf( tarArray[l] ) == -1 )
                {
					tarArray.splice( l, 1 );
					removed = true;
				}
			}
			
			return removed;
		}
    }
}