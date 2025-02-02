# Firstly!
This folder is going to be used for flashloans so with that we need to learn how pools are created, dealt with and swapped or flashloan with.

## Step 1:
create a pool and a few functions to utilise the pools and fetching the data. 
the below will be dot points on what i have learnt.

**OrderInfo** is created one a order is being placed, This order will check to see if there is any existing orders that match to do the swap desired and goes under the **Fill** process.

The **State** stores **Governance**, **History** and **Account**. It processes all requests, updating at least one of these stored structs.




# Smart voting system , asking permission by the holders to avoid scamming.
## Thoughts
What if we were to create a smart contract for our protocol and for us to fund or withdraw money from a treasury or liquidity pool, we need to ask the community for permission and then they are the ones to decide yes, no or how much...

**things to allow** should only have one proposal at a time, this means that the current proposal should be finalised and accepted, rejected or changed in terms of amount.
changing something

# Cetus create_pool_v2 function

```js
public fun create_pool_v2<CoinTypeA, CoinTypeB>(
        _config: &GlobalConfig,
        _pools: &mut Pools,
        _tick_spacing: u32,
        _initialize_price: u128,
        _url: String,
        _tick_lower_idx: u32,
        _tick_upper_idx: u32,
        _coin_a: Coin<CoinTypeA>,
        _coin_b: Coin<CoinTypeB>,
        _metadata_a: &CoinMetadata<CoinTypeA>,
        _metadata_b: &CoinMetadata<CoinTypeB>,
        _fix_amount_a: bool,
        _clock: &Clock,
        _ctx: &mut TxContext
    ):  (Position, Coin<CoinTypeA>, Coin<CoinTypeB>) {
        abort 0
    }
```


the pool struct that seems to be required is;
```js
/// The clmmpool
struct Pool<phantom CoinTypeA, phantom CoinTypeB> has key, store {
    id: UID,

    coin_a: Balance<CoinTypeA>,
    coin_b: Balance<CoinTypeB>,

    /// The tick spacing
    tick_spacing: u32,

    /// The numerator of fee rate, the denominator is 1_000_000.
    fee_rate: u64,

    /// The liquidity of current tick index
    liquidity: u128,

    /// The current sqrt price
    current_sqrt_price: u128,

    /// The current tick index
    current_tick_index: I32,

    /// The global fee growth of coin a,b as Q64.64
    fee_growth_global_a: u128,
    fee_growth_global_b: u128,

    /// The amounts of coin a,b owned to protocol
    fee_protocol_coin_a: u64,
    fee_protocol_coin_b: u64,

    /// The tick manager
    tick_manager: TickManager,

    /// The rewarder manager
    rewarder_manager: RewarderManager,

    /// The position manager
    position_manager: PositionManager,

    /// is the pool pause
    is_pause: bool,

    /// The pool index
    index: u64,

    /// The url for pool and postion
    url: String,

}
```


# the following is the pool create function 
```js 
/// Create a new pool, it only allow call by factory module.
    /// params
    ///     - `tick_spacing` We use tick to represent a discrete set of prices, and tick_spacing controls
    /// the density of the discrete price points.
    ///     - `init_sqrt_price` The clmmpool's initialize sqrt price. To facilitate calculation,
    /// clmmpool stores the square root of prices. Can I assist you with anything else?
    ///     - `fee_rate` The clmmpool's fee rate. Actually, the numerator of the fee rate is expressed in units,
    /// while the denominator is always 1,000,000. For example, 1000 represents 0.1% or 1000/1000000.
    ///     - `index` The "index" only affects the position names within the `clmmpool`, and these names are for
    /// display purposes only.
    ///     - `clock` The CLOCK of sui framework, we use it to set rand seed of skip list.
    ///     - `ctx` The TxContext
    public(friend) fun new<CoinTypeA, CoinTypeB>(
        _tick_spacing: u32,
        _init_sqrt_price: u128,
        _fee_rate: u64,
        _url: String,
        _index: u64,
        _clock: &Clock,
        _ctx: &mut TxContext
    ): Pool<CoinTypeA, CoinTypeB> {
        abort 0
    }

```