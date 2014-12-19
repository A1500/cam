package com.inspur.cams.bpt.bptinstitution.dao.jdbc;

import java.sql.Types;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.bptinstitution.dao.IBptHospitalDetailDao;
import com.inspur.cams.bpt.bptinstitution.data.BptHospitalDetail;


/**
 * @title:BptHospitalDao
 * @description:
 * @author:
 * @since:2011-06-09
 * @version:1.0
*/
 public class BptHospitalDetailDao extends EntityDao<BptHospitalDetail> implements IBptHospitalDetailDao{

 	public BptHospitalDetailDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return BptHospitalDetail.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from BptHospital");
	}

public void deleteDetail(String hospitalId) {
	executeUpdate("delete from Bpt_Hospital_Detail b ,bpt_hospital d where b.hospital_Id = d.hospital_Id and hospital_Id =?",new int[]{Types.VARCHAR},new Object[]{hospitalId});
	
}
public void batchDeleteByBptHospital(String[] fkId) {
	String[] sql = new String[fkId.length];
	for (int i = 0; i < fkId.length; i++) {
		sql[i] = "delete from BPT_HOSPITAL_DETAIL where HOSPITAL_ID='" + fkId[i] + "'";
	}
	batchUpdate(sql);
}

public void batchDeleteHospitalDetail(String[] fkId) {
	String[] sql = new String[fkId.length];
	for (int i = 0; i < fkId.length; i++) {
		sql[i] = "delete from BPT_HOSPITAL_DETAIL where ID='" + fkId[i] + "'";
	}
	batchUpdate(sql);
}
public DataSet getHospitalTotal(ParameterSet pset){//优抚医院查询统计
	StringBuffer sql = new StringBuffer();
	sql.append(" select * from ");
	sql.append(" (select substr(g.id, 0, 4) || '00000000' as cid, g.name from dic_city g  ");
	sql.append(" where g.id = substr(g.id, 0, 4) || '00000000' ");
	sql.append(" group by substr(g.id, 0, 4) || '00000000', name) k, ");
	sql.append(" (select  substr(t.domicile_code, 0, 4) || '00000000' as domcode, t.unit_fullname, ");
	sql.append("  (case t.ADMINISTRATIVE_LEVEL when '1' then '正县' when'2' then'副县' when '3' then '正科' when '4' then '副科' end) as ADMINISTRATIVE_LEVEL, ");
	sql.append(" (TO_NUMBER(t.CENTRAL_FUNDS) + TO_NUMBER(t.PLACE_FUNDS) + TO_NUMBER(t.BPT_MEDICAL_FUNDS) + TO_NUMBER(t.BPT_LIVE_FUNDS) + TO_NUMBER(t.OFFICIAL_FUNDS) + TO_NUMBER(t.OTHER_FUNDS)) as PUTFUNDS, ");
	sql.append("  t.NEWEXPANSION, t.NEWEQUIPMENT,t.YEAR_ACTUAL_BED,t.ADD_BED, t.SERVICE, t.REAR_SERVICE_NUM, t.RESORT,t.YEAR_BPT_NUM, t.SOCIETY_NUM, ");
	sql.append("  t.NUMINYEAR,t.MENTALNUM, ");
	sql.append(" (case t.IFPREVENTIONNET when '0' then '否' when'1' then'是' end) as IFPREVENTIONNET, ");
	sql.append("  t.HOSPITALIZATION,t.MOBILEMEDICAL,t.TELCONSULTATION, nvl(t.TREATMENTALNUM,0) TREATMENTALNUM,t.INCOME ");
	sql.append("  from BPT_HOSPITAL_DETAIL t, DIC_CITY d ");
	sql.append("  WHERE substr(t.domicile_code, 0, 4) || '00000000' = d.id and t.years=?) i, ");
	sql.append(" (SELECT SUM((TO_NUMBER(t.CENTRAL_FUNDS) + TO_NUMBER(t.PLACE_FUNDS) +  TO_NUMBER(t.BPT_MEDICAL_FUNDS) + TO_NUMBER(t.BPT_LIVE_FUNDS) + TO_NUMBER(t.OFFICIAL_FUNDS) + TO_NUMBER(t.OTHER_FUNDS))) as PUTFUNDS_SUM, ");
	sql.append("  SUM(t.NEWEXPANSION) as NEWEXPANSION_SUM, SUM(t.NEWEQUIPMENT) AS NEWEQUIPMENT_SUM, SUM(t.YEAR_ACTUAL_BED) AS YEAR_ACTUAL_BED_SUM, SUM(t.ADD_BED) AS ADD_BED_SUM,  SUM(t.SERVICE) AS SERVICE_SUM, ");
	sql.append(" SUM(t.REAR_SERVICE_NUM) AS REAR_SERVICE_NUM_SUM, SUM(t.RESORT) AS RESORT_SUM, SUM(t.YEAR_BPT_NUM) AS YEAR_BPT_NUM_SUM, SUM(t.SOCIETY_NUM) AS SOCIETY_NUM_SUM, SUM(t.NUMINYEAR) AS NUMINYEAR_SUM, ");
	sql.append("  SUM(t.MENTALNUM) AS MENTALNUM_SUM, SUM(t.HOSPITALIZATION) AS HOSPITALIZATION_SUM, SUM(t.MOBILEMEDICAL) AS MOBILEMEDICAL_SUM, SUM(t.TELCONSULTATION) AS TELCONSULTATION_SUM,SUM(t.TREATMENTALNUM) AS TREATMENTALNUM_SUM, ");
	sql.append("  SUM(t.INCOME) AS INCOME_SUM, c.IFPREVENTIONNET_SUM,  l1.ADMINISTRATIVE_LEVEL_SUM1, l2.ADMINISTRATIVE_LEVEL_SUM2, l3.ADMINISTRATIVE_LEVEL_SUM3, l4.ADMINISTRATIVE_LEVEL_SUM4, l5.ADMINISTRATIVE_LEVEL_SUM5 ");
	sql.append("  from BPT_HOSPITAL_DETAIL t, DIC_CITY d, ");
	sql.append("  (select count(a.IFPREVENTIONNET) as IFPREVENTIONNET_SUM from BPT_HOSPITAL_DETAIL a  where a.IFPREVENTIONNET = '1' and  a.years=?) c, ");
	sql.append(" (select count(a1.ADMINISTRATIVE_LEVEL) as ADMINISTRATIVE_LEVEL_SUM1 from BPT_HOSPITAL_DETAIL a1 where  a1.years=?) l1, ");
	sql.append(" (select count(a2.ADMINISTRATIVE_LEVEL) as ADMINISTRATIVE_LEVEL_SUM2 from BPT_HOSPITAL_DETAIL a2  where a2.ADMINISTRATIVE_LEVEL = '1' and  a2.years=?) l2, ");
	sql.append(" (select count(a3.ADMINISTRATIVE_LEVEL) as ADMINISTRATIVE_LEVEL_SUM3  from BPT_HOSPITAL_DETAIL a3 where a3.ADMINISTRATIVE_LEVEL = '2' and  a3.years=?) l3, ");
	sql.append("  (select count(a4.ADMINISTRATIVE_LEVEL) as ADMINISTRATIVE_LEVEL_SUM4 from BPT_HOSPITAL_DETAIL a4 where a4.ADMINISTRATIVE_LEVEL = '3' and  a4.years=?) l4, ");
	sql.append("  (select count(a5.ADMINISTRATIVE_LEVEL) as ADMINISTRATIVE_LEVEL_SUM5 from BPT_HOSPITAL_DETAIL a5 where a5.ADMINISTRATIVE_LEVEL = '4' and  a5.years=?) l5 ");
	sql.append("  WHERE substr(t.domicile_code, 0, 4) || '00000000' = d.id and t.years=? ");
	sql.append(" group by IFPREVENTIONNET_SUM,  ADMINISTRATIVE_LEVEL_SUM1,  ADMINISTRATIVE_LEVEL_SUM2,  ADMINISTRATIVE_LEVEL_SUM3, ADMINISTRATIVE_LEVEL_SUM4, ADMINISTRATIVE_LEVEL_SUM5) counts ");
	sql.append("  where k.cid = i.domcode(+) order by cid ");
	String year = (String)pset.get("year");
	int[] type = new int[8];
    Object[] obj = new Object[8];
	for(int i=0;i<8;i++){
		type[i]=Types.VARCHAR;
	    obj[i] = year;
	}
	return super.executeDataset(sql.toString(),type,obj, true);
}
public DataSet getMaxYear(ParameterSet pset){
	String hospitalId = (String)pset.get("hospitalId");
	String sql = "select max(t.years) as mx  from bpt_hospital_detail t where t.hospital_id='"+hospitalId+"'";
	return super.executeDataset(sql.toString(), true);
}

}
