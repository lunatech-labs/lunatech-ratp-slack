package repositories

import javax.inject.Inject
import models.UserHomeStation
import play.api.db.slick.DatabaseConfigProvider
import slick.jdbc.JdbcProfile

import scala.concurrent.{ExecutionContext, Future}

class UserHomeRepository @Inject()(dbConfigProvider: DatabaseConfigProvider)(implicit ec: ExecutionContext) {
  private val dbConfig = dbConfigProvider.get[JdbcProfile]

  import dbConfig._
  import profile.api._

  private class UserHomeTable(tag: Tag) extends Table[UserHomeStation](tag, "USERHOME") {

    val id = column[Int]("ID", O.PrimaryKey, O.AutoInc)
    val userId = column[String]("USERID")
    val trainType = column[String]("TRAINTYPE")
    val trainCode = column[String]("TRAINCODE")
    val station = column[String]("STATION")

    val * = (id, userId, trainType, trainCode, station) <> (UserHomeStation.tupled, UserHomeStation.unapply)
  }

  private val userHomes = TableQuery[UserHomeTable]

  def insertOrUpdate(userHomeStation: UserHomeStation) = db.run {
    userHomes.filter(_.userId === userHomeStation.userId).delete
  } map {_ => db.run(userHomes += userHomeStation)}

  def selectStationFromUser(userId: String): Future[Option[UserHomeStation]] = db.run {
    userHomes.filter(_.userId === userId).result
  }.map(_.headOption)

}
