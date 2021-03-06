// AutoAttack - the main SWF object

package {

    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.events.MouseEvent;

    public class AutoAttack extends MovieClip {

        private var preload : Preloader;
        private var introMovie : IntroMovieAsset;
        private var titleScreen : TitleScreenAsset;

        private var level : Level;

        public function AutoAttack() {
            preload = new Preloader(this, donePreloading);
            introMovie = null;
            titleScreen = null;
            level = null;
        }

        private function donePreloading() : void {
            // go to frame 200 to get classes working
            gotoAndStop(200);
            createIntroMovie();
        }

        private function createIntroMovie() : void {
            preload = null; 
            introMovie = new IntroMovieAsset();
            introMovie.addEventListener(Event.EXIT_FRAME, checkIntroMovieOver);

            this.addChild(introMovie);
        }

        private function checkIntroMovieOver(e:Event) : void {
            if( introMovie.currentFrame >= introMovie.totalFrames )
                skipIntroMovie();
        }

        private function skipIntroMovie() : void {
            // it's over - clean up
            introMovie.removeEventListener(Event.EXIT_FRAME, 
                checkIntroMovieOver);
            this.removeChild(introMovie);
            introMovie = null;
            
            // create title screen
            titleScreen = new TitleScreenAsset();
            this.addChild(titleScreen);

            titleScreen.inner_mc.play_btn.addEventListener(MouseEvent.MOUSE_UP, 
                playGame);
        }

        private function playGame(e:Event) : void {
            titleScreen.inner_mc.play_btn.removeEventListener(
                MouseEvent.MOUSE_UP, playGame);
            closeTitleScreen();

            // start gameplay
            level = new Level(1, stage.stageWidth, stage.stageHeight);
            this.addChild(level);
        }

        private function closeTitleScreen() : void {
            this.removeChild(titleScreen);
            titleScreen = null;
        }
    }
}
