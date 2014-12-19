package com.inspur.cams.comm.informUtil;

import java.sql.Types;

import org.loushang.next.data.DataSet;
import org.loushang.persistent.util.domain.BaseJdbcDao;

public class InformOrganTreeDao extends BaseJdbcDao{


   /***
    * @说明：根据传入的organCode获取到记录
    * @param organCode
    */
   public DataSet query(String organCode){
	   StringBuffer bf=new StringBuffer();
	   bf.append("SELECT S.ORGAN_CODE AS CODE,S.SHORT_NAME AS NAME, S.ORGAN_TYPE AS TYPE FROM PUB_ORGAN S WHERE S.ORGAN_ID IN(SELECT T.ORGAN_ID FROM PUB_STRU T,PUB_ORGAN P WHERE T.PARENT_ID = P.ORGAN_ID AND P.ORGAN_CODE=?) AND S.ORGAN_TYPE in ('12', '13','14', '15') AND S.IN_USE='1' ORDER BY CODE ");
	  return this.executeDataset(bf.toString(), new int[]{Types.VARCHAR}, new Object[]{organCode}, true);
   }
   public DataSet queryBySql(String organCode){
	   StringBuffer bf=new StringBuffer();
	   bf.append("SELECT S.ORGAN_CODE AS CODE,S.SHORT_NAME AS NAME, S.ORGAN_TYPE AS TYPE FROM PUB_ORGAN S WHERE S.ORGAN_ID IN(SELECT T.ORGAN_ID FROM PUB_STRU T,PUB_ORGAN P WHERE T.PARENT_ID = P.ORGAN_ID AND P.ORGAN_CODE=?) AND S.ORGAN_TYPE in ('12', '13') AND S.IN_USE='1' ORDER BY CODE ");
	   return this.executeDataset(bf.toString(), new int[]{Types.VARCHAR}, new Object[]{organCode}, true);
   }
	@Override
	protected void initDao() {
		// TODO Auto-generated method stub

	}

}
