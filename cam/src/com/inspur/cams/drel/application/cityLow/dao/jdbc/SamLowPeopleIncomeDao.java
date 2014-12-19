package com.inspur.cams.drel.application.cityLow.dao.jdbc;

import java.math.BigDecimal;
import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.dao.SqlCreator;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.persistent.jdbc.core.JdbcTemplate;
import org.loushang.persistent.jdbc.db.adapter.DBAdapter;

import com.inspur.cams.drel.application.cityLow.dao.ISamLowPeopleIncomeDao;
import com.inspur.cams.drel.application.cityLow.data.SamLowPeopleIncome;

/**
 * 低收入家庭成员可支配收入表dao
 * @author 
 * @date 2014-03-11
 */
public class SamLowPeopleIncomeDao extends EntityDao<SamLowPeopleIncome> implements ISamLowPeopleIncomeDao {
	
	@Override
	public Class<SamLowPeopleIncome> getEntityClass() {
		return SamLowPeopleIncome.class;
	}

	public DataSet queryThree(ParameterSet parameter) {
		// TODO Auto-generated method stub
		String familyId = (String)parameter.get("FAMILY_ID");
		String peopleId =(String)parameter.get("PEOPLE_ID");
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT * ");
		sql.append(" FROM BASEINFO_PEOPLE PEP,SAM_LOW_PEOPLE_INCOME INC,SAM_LOW_PEOPLE_PROPERTY PRO");
		sql.append(" WHERE PEP.PEOPLE_ID= INC.PEOPLE_ID AND PEP.PEOPLE_ID= PRO.PEOPLE_ID");
		if(familyId!=null){
			sql.append(" AND PEP.FAMILY_ID=? ");	
			sql.append(" ORDER BY PEP.RELATIONSHIP_TYPE ");	
			return executeDataset(sql.toString(),new int[]{Types.VARCHAR},new Object[]{familyId},true);
		}else{
			sql.append(" AND PEP.PEOPLE_ID=?");			
			return executeDataset(sql.toString(),new int[]{Types.VARCHAR},new Object[]{peopleId},true);				
		}
	}
	//用于增删改家庭成员信息后更新家庭信息
	public DataSet queryForUpDateFamilyInfo(ParameterSet pset) {
		// TODO Auto-generated method stub
		String familyId = (String)pset.get("familyId");
		String peopleId =(String)pset.get("peopleId");
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT PEP.FAMILY_ID,PEP.PEOPLE_ID,INC.TOTAL_INCOME,PRO.TOTAL_PROPERTY ");
		sql.append(" FROM BASEINFO_PEOPLE PEP,SAM_LOW_PEOPLE_INCOME INC,SAM_LOW_PEOPLE_PROPERTY PRO");
		sql.append(" WHERE PEP.PEOPLE_ID= INC.PEOPLE_ID AND PEP.PEOPLE_ID= PRO.PEOPLE_ID");
		if(familyId!=null){
			sql.append(" AND PEP.FAMILY_ID=? ");	
			sql.append(" ORDER BY PEP.RELATIONSHIP_TYPE ");
			return executeDataset(sql.toString(),new int[]{Types.VARCHAR},new Object[]{familyId},true);
		}
		else{
			sql.append(" AND FAMILY_ID = (SELECT FAMILY_ID FROM BASEINFO_PEOPLE WHERE PEOPLE_ID=?)");			
			return executeDataset(sql.toString(),new int[]{Types.VARCHAR},new Object[]{peopleId},true);				
		}
	}

	public DataSet lowQueryByPeople(ParameterSet pset) {
		String peopleName=(String)pset.getParameter("PEOPLE_NAME@=");
		String cardNum=(String)pset.getParameter("FAMILY_CARD_NO@=");
		String type=(String)pset.getParameter("ASSISTANCE_TYPE@=");
		StringBuffer sqlPre = new StringBuffer();
		if(peopleName==null&&cardNum==null){
			sqlPre.append("SELECT * FROM BASEINFO_FAMILY WHERE ASSISTANCE_TYPE='"+type+"'");
		}else{
		
			sqlPre.append(" SELECT FAM.*");
			sqlPre.append(" FROM BASEINFO_PEOPLE PEP,BASEINFO_FAMILY FAM");
			sqlPre.append(" WHERE PEP.FAMILY_ID=FAM.FAMILY_ID AND FAM.ASSISTANCE_TYPE='"+type+"'");
			if(peopleName!=null){
				sqlPre.append(" AND NAME='"+peopleName+"'");
			}
			if(cardNum!=null){
				sqlPre.append(" AND FAMILY_CARD_NO='"+cardNum+"'");
			}
		}	
		
		return executeDataset(sqlPre.toString(), true);
	}

	public void batchDeleteFamilyAll(String[] delIds) {
		// TODO Auto-generated method stub
		//意见delete from SAM_LOW_APPLY_INFO
		String sqlconfig = " DELETE FROM SAM_LOW_APPLY_INFO WHERE FAMILY_ID=?";
		//家庭delete from baseinfo_family where assistance_type='D2'
		String sqlfamily = "DELETE FROM BASEINFO_FAMILY WHERE ASSISTANCE_TYPE='D2' AND FAMILY_ID=?";
		//家庭成员delete  from baseinfo_people where 
		String sqlpeople = " DELETE FROM BASEINFO_PEOPLE WHERE FAMILY_ID=?";
		//赡养人delete from SAM_LOW_SUPPORT_PEOPLE
		String sqlsupport = "DELETE FROM SAM_LOW_SUPPORT_PEOPLE WHERE FAMILY_ID=?";
		//以上可直接使用familyId（主键或外键删除）
		//家庭成员可支配收入DELETE FROM SAM_LOW_PEOPLE_INCOME
		String sqlincome = " DELETE FROM SAM_LOW_PEOPLE_INCOME WHERE PEOPLE_ID IN (SELECT PEOPLE_ID FROM BASEINFO_PEOPLE WHERE FAMILY_ID =?)";
		//家庭成员固定资产DELETE from SAM_LOW_PEOPLE_PROPERTY 
		String sqlproperty = " DELETE FROM SAM_LOW_PEOPLE_PROPERTY WHERE PEOPLE_ID IN(SELECT PEOPLE_ID FROM BASEINFO_PEOPLE WHERE FAMILY_ID =?)";
		
		for(int i=0;i<delIds.length;i++){
			String delId = delIds[i];
			int a = executeUpdate(sqlincome, new int[]{Types.VARCHAR}, new Object[]{delId});
			int b = executeUpdate(sqlproperty, new int[]{Types.VARCHAR}, new Object[]{delId});
			int c = executeUpdate(sqlconfig, new int[]{Types.VARCHAR}, new Object[]{delId});
			int d = executeUpdate(sqlsupport, new int[]{Types.VARCHAR}, new Object[]{delId});
			int e = executeUpdate(sqlfamily, new int[]{Types.VARCHAR}, new Object[]{delId});
			int f = executeUpdate(sqlpeople, new int[]{Types.VARCHAR}, new Object[]{delId});
			System.out.println("用户编号为"+delId+"的用户共删除："+a+"条可支配，"+b+"条资产，"+c+"条意见，"+d+"条赡养，"+e+"条家庭，"+f+"条家庭成员");	
		}
	
		
	}

	public DataSet lowFamilyCount(ParameterSet pset) {
		// TODO Auto-generated method stub
		String apanageCode=(String)pset.get("apanageCode");
		String apanagelevel=(String)pset.get("apanagelevel");
		String startTime=(String)pset.get("startTime");
		String endTime=(String)pset.get("endTime");
		pset.remove("apanageCode");
		pset.remove("apanagelevel");
		pset.remove("startTime");
		pset.remove("endTime");
				
		//System.out.println(apanageCode+"--"+apanagelevel+"---"+startTime+"---"+endTime+"");
		StringBuffer sqlpre=new StringBuffer();
		sqlpre.append("SELECT");
		sqlpre.append(" COUNT(FAMWEL.FAMILY_ID) FAMILYCOUNT,FAMWEL.APANAGE_NAME APANAGE");
		sqlpre.append(",SUM(FAMWEL.FAMILY_INCOME) FAMINCOME,SUM(FAMWEL.FAMILY_PROPERTY) FAMILYPROPERTY");
		sqlpre.append(" FROM (SELECT PEP.FAMILY_ID,FAM.APANAGE_NAME, SUM(INC.TOTAL_INCOME) FAMILY_INCOME, FAM.PROVINCE,FAM.CITY,FAM.COUNTY,FAM.TOWN,FAM.VILLAGE,SUM(PRO.TOTAL_PROPERTY) FAMILY_PROPERTY");
		sqlpre.append(" FROM BASEINFO_PEOPLE PEP,SAM_LOW_PEOPLE_INCOME INC,SAM_LOW_PEOPLE_PROPERTY PRO, BASEINFO_FAMILY FAM");
		sqlpre.append(" WHERE PEP.PEOPLE_ID= INC.PEOPLE_ID AND PEP.PEOPLE_ID= PRO.PEOPLE_ID AND  PEP.FAMILY_ID=FAM.FAMILY_ID AND FAM.ASSISTANCE_TYPE='D2'");
		sqlpre.append(" GROUP BY PEP.FAMILY_ID,FAM.APANAGE_NAME, FAM.PROVINCE,FAM.CITY,FAM.COUNTY,FAM.TOWN,FAM.VILLAGE) FAMWEL,SAM_LOW_APPLY_INFO APP");
		sqlpre.append(" WHERE FAMWEL.FAMILY_ID=APP.FAMILY_ID ");
		
		if("0".equals(apanagelevel)){
			sqlpre.append(" AND FAMWEL.PROVINCE='"+apanageCode+"' " );
		}
		else if("1".equals(apanagelevel)){
			sqlpre.append(" AND FAMWEL.CITY='"+apanageCode+"' " );
		}
		else if("2".equals(apanagelevel)){
			sqlpre.append(" AND FAMWEL.COUNTY='"+apanageCode+"' " );
		}
		else if("3".equals(apanagelevel)){
			sqlpre.append(" AND FAMWEL.TOWN='"+apanageCode+"' " );
		}
		else if("4".equals(apanagelevel)){
			sqlpre.append(" AND FAMWEL.VILLAGE='"+apanageCode+"' " );
		}
		if(startTime!=null&&!("".equals(startTime))&&!("null".equals(startTime))){
			sqlpre.append("  AND APP.APPLY_DATE>'"+startTime+"' ");
		}
		if(endTime!=null&&!("".equals(endTime))&&!("null".equals(endTime))){
			sqlpre.append(" AND APP.APPLY_DATE<'"+endTime+"' ");
		}
		sqlpre.append(" GROUP BY FAMWEL.APANAGE_NAME");
		
		int start = pset.getPageStart();	//当前页条数，为页数乘以每页条数
		int limit = pset.getPageLimit();	//每页的条数
		int totalCount = 0;//数据总条数
		
		//System.out.println("start:"+start+"----limit"+limit);
		
		String sql = SqlCreator.getSimpleQuerySql(pset,sqlpre.toString(),this.getDataSource());
		
		DataSet ds=null;
		if(start>=0&&limit>=0){
			
			JdbcTemplate jdbcTemplate = getDefaultJdbcTemplate();
			DBAdapter dbAdapter = jdbcTemplate.getDbAdapter();
			
			String querySql = dbAdapter.getLimitString(sql);//获取分页查询语句
	        String countSql = dbAdapter.getCountSql(sql);//获取总条数查询语句
	        
	        //对数据进行转换
	       
	        //querySql = querySql.replaceFirst("\\?", String.valueOf(start*limit+limit));
	        querySql = querySql.replaceFirst("\\?", String.valueOf(start+limit));
	        querySql = querySql.replaceFirst("\\?", String.valueOf(start));
	        
	        //System.out.println("查询SQL:" + querySql + "\n总数SQL：" + countSql);
	        
	       
	        DataSet countDs = executeDataset(countSql, true);
	        if(countDs.getCount() > 0){
	        	Record r = countDs.getRecord(0);
	        	BigDecimal cbd =(BigDecimal) r.get("COUNT(1)");
	        	//totalCount = Integer.parseInt((String)r.get("COUNT(1)"));	
	        	totalCount = cbd.intValue();
	        }
	        
			ds=executeDataset(querySql,true);			
			ds.setTotalCount(totalCount);
		}else if(start<0||limit<0){
			ds=executeDataset(sql,false);
				
		}
		//DataSet ds = executeDataset(sqlpre.toString(), true);
		return ds;
	}
	public DataSet lowFamilyCountTable(ParameterSet pset) {
		DataSet ds=null;
		String code=(String)pset.getParameter("CODEUP");
		if(code==null){
			code="370000000000";
		}
				
		String start =(String)pset.getParameter("STARTDATE");
		String end =(String)pset.getParameter("ENDDATE");
		StringBuffer sqlpre =new StringBuffer();
		sqlpre.append(" SELECT COUNT(CNT.FAMILY_ID) NUM, SUM(NVL(CNT.FAMILY_INCOME,0)) TOTALINC,SUM(NVL(CNT.FAMILY_PROPERTY,0)) TOTALPRO,CNT.NAME NAME,CNT.ID ID");
		sqlpre.append(" FROM (SELECT APL.FAMILY_ID,APL.APANAGE_NAME,APL.APANAGE_CODE,APL.FAMILY_INCOME,APL.FAMILY_PROPERTY,APL.PROV,NVL(APL.APPLY_DATE,'"+start+"') APPLY_DATE,CIT.*");
		sqlpre.append(" FROM (");
		sqlpre.append(" SELECT PEP.FAMILY_ID,FAM.APANAGE_NAME,FAM.APANAGE_CODE, SUM(INC.TOTAL_INCOME) FAMILY_INCOME");
		sqlpre.append(" ,SUM(PRO.TOTAL_PROPERTY) FAMILY_PROPERTY ,RPAD(SUBSTR(FAM.APANAGE_CODE,1,"+getSubstrIndex(code)+"),12,'0') PROV,MAX(APP.APPLY_DATE) APPLY_DATE");
		sqlpre.append(" FROM BASEINFO_PEOPLE PEP,SAM_LOW_PEOPLE_INCOME INC,SAM_LOW_PEOPLE_PROPERTY PRO, BASEINFO_FAMILY FAM ,SAM_LOW_APPLY_INFO APP ");
		sqlpre.append(" WHERE PEP.PEOPLE_ID= INC.PEOPLE_ID AND PEP.PEOPLE_ID= PRO.PEOPLE_ID");
		sqlpre.append(" AND PEP.FAMILY_ID=FAM.FAMILY_ID AND FAM.FAMILY_ID=APP.FAMILY_ID");
		sqlpre.append(" AND FAM.ASSISTANCE_TYPE='D2'");
		sqlpre.append(" GROUP BY PEP.FAMILY_ID,FAM.APANAGE_NAME,FAM.APANAGE_CODE");
		sqlpre.append(" ) APL RIGHT JOIN   DIC_CITY CIT ON CIT.ID =APL.PROV");
		sqlpre.append(" WHERE  CIT.UPS='"+code+"'");
		sqlpre.append(" ) CNT WHERE 1=1");
		
		if(start!=null){
			sqlpre.append(" AND  CNT.APPLY_DATE>='"+start+"'");
		}if(end!=null){
			sqlpre.append(" AND CNT.APPLY_DATE<='"+end+"'");
		}
		sqlpre.append("  GROUP BY CNT.NAME,CNT.ID ORDER BY CNT.ID");
		
		ds=executeDataset(sqlpre.toString(),false);
		return ds;
	}
	
	public DataSet lowFamilyAvgCount(ParameterSet pset,String column) {
		// TODO Auto-generated method stub
		DataSet ds=null;
		
		int[] limit = {600,800,1000};//设置的分档线
		//String column="YEAR_AVERAGE_INCOME";
		if("BUILD_AVERAGE_AREA".equals(column)){
			limit=new int[]{10,20,50};
		}
		
		String code=(String)pset.getParameter("CODEUP");
		if(code==null){
			code="370100000000";//济南市的代码
		}				
		String start =(String)pset.getParameter("STARTDATE");
		String end =(String)pset.getParameter("ENDDATE");
		StringBuffer sqlpre =new StringBuffer();
		sqlpre.append(" SELECT ID,NAME,");
		
		String[] f = new String[limit.length+1];
		String[] h = new String[limit.length+1];
		for(int i=0;i<limit.length;i++){
			f[i]="F"+(i+1+"");
			h[i]="H"+(i+1+"");
			if(i==(limit.length-1)){
				f[i+1]="F"+(i+2+"");
				h[i+1]="H"+(i+2+"");
			}			
		}
		StringBuilder fba = new StringBuilder();
		StringBuilder hba = new StringBuilder();
		StringBuilder fbd = new StringBuilder();
		StringBuilder hbd = new StringBuilder();
		for(int i=0;i<f.length;i++){
			if(i==(f.length-1)){
				fba.append(f[i]);
				hba.append(h[i]);
				fbd.append(f[i]);
				hbd.append(h[i]);
				break;
			}
			fba.append(f[i]+"+");
			hba.append(h[i]+"+");
			fbd.append(f[i]+",");
			hbd.append(h[i]+",");			
		}
		String hAdd=hba.toString();
		String fAdd=fba.toString();
		String fDot=fbd.toString();
		String hDot=hbd.toString();
		sqlpre.append("("+fAdd+") TOTALF,("+hAdd+") TOTALH,"+fDot+","+hDot+"");
		
		sqlpre.append(" FROM (SELECT ID,NAME,");
		for(int i=0;i<limit.length;i++){
			if(i==0){
				sqlpre.append(" COUNT(CASE WHEN "+column+" <="+limit[i]+" THEN 'a' END) F"+(i+1)+", NVL(SUM(CASE WHEN "+column+" <="+limit[i]+" THEN BF.NUM END),0) H"+(i+1)+",");
			}
			if(i>0){
				sqlpre.append(" COUNT(CASE WHEN "+column+">"+limit[i-1]+" AND "+column+"<="+limit[i]+" THEN 'b' END) F"+(i+1)+", NVL(SUM(CASE WHEN "+column+">"+limit[i-1]+" AND "+column+"<="+limit[i]+" THEN BF.NUM END),0) H"+(i+1)+",");
			}
			//sqlpre.append(" ,COUNT(CASE WHEN "+column+">"+limit[1]+" AND "+column+"<="+limit[2]+" THEN 'c' END) F3, NVL(SUM(CASE WHEN "+column+">"+limit[1]+" AND "+column+"<="+limit[2]+" THEN BF.NUM END),0) H3");
			
			if(i==(limit.length-1)){
				sqlpre.append(" COUNT( CASE WHEN "+column+">"+limit[i]+" THEN 'd' END) F"+(i+2)+", NVL(SUM( CASE WHEN "+column+">"+limit[i]+" THEN BF.NUM END),0) H"+(i+2)+"");
			}
		}
		sqlpre.append(" FROM"); 
		sqlpre.append(" (SELECT ID,NAME,UPS FROM DIC_CITY WHERE IS_SELF<>'1' AND UPS='"+code+"')"); 
		sqlpre.append(" CIT LEFT OUTER JOIN ");
		sqlpre.append(" (SELECT FAM.FAMILY_ID, FAM.FAMILY_NAME,RPAD(SUBSTR(FAM.APANAGE_CODE,1,"+getSubstrIndex(code)+"),12,'0') CODE, FAM."+column+"");
		sqlpre.append(" ,FAM.YEAR_INCOME,FAM.PEOPLE_NUM NUM,INF.APPLY_DATE ");
		sqlpre.append(" FROM BASEINFO_FAMILY FAM ,SAM_LOW_APPLY_INFO INF ");
		
		sqlpre.append(" WHERE FAM.FAMILY_ID=INF.FAMILY_ID AND FAM.ASSISTANCE_TYPE='D2'");
		if(start!=null){
			sqlpre.append(" AND INF.APPLY_DATE>='"+start+"'");
		}
		if(end!=null){
			sqlpre.append(" AND INF.APPLY_DATE<='"+end+"'");
		}
		sqlpre.append(" ) BF ON CIT.ID=BF.CODE GROUP BY ID,NAME)");
		sqlpre.append(" ORDER BY ID");
		//System.out.println(sqlpre.toString());
		ds=executeDataset(sqlpre.toString(), true);
		//System.out.println("dao:"+ds.getCount());
		return ds;
	}
	private int getSubstrIndex(String releaseArea) {
        if(releaseArea.endsWith("0000000000")){//省370000000000
			return 4;
		} else if (releaseArea.endsWith("00000000")){//市370100000000
			return 6;
		} else if (releaseArea.endsWith("000000")){//县370104000000
			return 9;
		} else if (releaseArea.endsWith("000")){//乡370104003000
			return 12;
		}
        return 12;
	}
}