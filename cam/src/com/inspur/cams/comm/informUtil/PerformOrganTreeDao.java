package com.inspur.cams.comm.informUtil;

import org.loushang.next.data.DataSet;
import org.loushang.persistent.util.domain.BaseJdbcDao;

public class PerformOrganTreeDao extends BaseJdbcDao{


   /***
    * @说明：根据传入的organCode获取到记录
    * @param organCode
    */
   public DataSet query(String organCode){
	   String sql="";
	   sql+= " SELECT S.ORGAN_CODE AS CODE,S.SHORT_NAME AS NAME FROM PUB_ORGAN S WHERE S.ORGAN_ID IN(";
       sql+= " SELECT T.ORGAN_ID FROM PUB_STRU T,PUB_ORGAN P WHERE T.PARENT_ID = P.ORGAN_ID AND P.ORGAN_CODE='";
       sql+=	organCode;
       sql+=	"') AND S.ORGAN_TYPE != '8' AND　S.IN_USE='1'";
       sql+=	" ORDER BY CODE";

      //System.out.println("getOrganSql==="+sql);
	  return executeDataset(sql,true);
   }

	@Override
	protected void initDao() {
		// TODO Auto-generated method stub

	}

}
