class DemoController < ApplicationController
  def d1
    #render template: 'demo'

  end

  def d2
    logger.debug("this is debug.")
    logger.info("this is info.")
    logger.warn("this is warn.")
    logger.error("this is error.")
    logger.fatal("this is fatal.")
    render template: 'demo2'
  end
end