package com.inspur.cams.sorg.report.dao.jdbc;

import java.math.BigDecimal;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.Field;
import org.loushang.next.data.FieldSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.util.domain.BaseJdbcDao;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.sorg.base.data.SomPartyMember;
import com.inspur.cams.sorg.report.dao.ISomPartyReportDao;
/**
 * @title 社会组织党建报表查询Dao
 * @author 闫亮亮
 * @time 2012年9月25日16:01:44
 */
@SuppressWarnings("unchecked")
public class SomPartyReportDao  extends BaseJdbcDao implements ISomPartyReportDao {
	@Override
	protected void initDao() {
		// TODO Auto-generated method stub
		
	}
	/**
	 * 两年党员数综合比较
	 * @param pset
	 * @return
	 */
	public DataSet queryMemberTwoYearCompare(ParameterSet pset) {
		StringBuffer sql=new StringBuffer();
		String ifLike=(String)pset.getParameter("ifLike");
		String morgArea=BspUtil.getCorpOrgan().getOrganCode();
		sql.append("select  ");
		//去年总数
		sql.append(" sum(case  when t.normal_date < to_char(sysdate, 'yyyy ') then  1  else   0  end ) last_sum,  ");
		//发展党员
		sql.append(" sum(case  when t.application_date  like to_char(sysdate, 'yyyy')||'%'  then  1  else   0  end ) beto_party,  ");
		//转入组织关系
		sql.append("  sum(case  when t.in_type in ('0','1') and t.in_time like to_char(sysdate, 'yyyy')||'%'  then  1  else   0  end ) party_in,  ");
		//整建制转入
		sql.append(" sum(case  when t.in_type='1' and t.in_time like to_char(sysdate, 'yyyy')||'%'  then  1  else   0  end ) rot_in,  ");
		//转出组织关系
		sql.append(" sum(case  when t.out_type in ('0','1') and t.out_time like to_char(sysdate, 'yyyy')||'%'  then  1  else   0  end ) out_tissue,  ");
		//整建制转出
		sql.append("  sum(case  when  t.out_type='1' and t.out_time like to_char(sysdate, 'yyyy')||'%'  then  1  else   0  end ) rot_tissue, ");
		//本年底实有数
		sql.append(" sum(case  when t.application_date < to_char(add_months(trunc(sysdate, 'Year'), +12), 'yyyy')  and t.member_status not in('4','5')  then  1  else   0  end ) year_really ");
		
		sql.append(" from som_party_member t  where t.morg_area ");
		
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		typeList.add(Types.VARCHAR);
		if("1".equals(ifLike)){
			sql.append(" like ?");
			argsList.add(getAreaCodeLikePrefix(morgArea)+"%");
		}else{
			sql.append(" = ? ");
			argsList.add(morgArea);
		}
		//关联查询党员变动
		DataSet ds=queryMemberTwoYearChange(ifLike,morgArea);
		
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		DataSet ds1=executeDataset(sql.toString(), types, args,  true);
		if(ds1.getCount()>0){
			FieldSet fs = ds1.getFieldSet();
			Field f = new Field();
			f.setName("RETO_PARTY");
			fs.add(f);
			fs.add(new Field("OUT_PARTY"));
			fs.add(new Field("STOP_PARTY"));
			fs.add(new Field("DIE_PARTY"));
			
			fs.add(new Field("NEW_SUM"));
			fs.add(new Field("NEW_DOWN"));
			fs.add(new Field("SHOULD_SUM"));
			fs.add(new Field("BALANCE_SUM"));
			for (int i = 0; i < ds1.getCount(); i++) {
				ds1.getRecord(i).set("RETO_PARTY", ds.getRecord(0).get("RETO_PARTY"));
				ds1.getRecord(i).set("OUT_PARTY", ds.getRecord(0).get("OUT_PARTY"));
				ds1.getRecord(i).set("STOP_PARTY", ds.getRecord(0).get("STOP_PARTY"));
				ds1.getRecord(i).set("DIE_PARTY", ds.getRecord(0).get("DIE_PARTY"));
				
//				ds1.getRecord(i).set("NEW_SUM", new BigDecimal((String)ds.getRecord(0).get("BETO_PARTY")).add(
//						new BigDecimal( (String)ds.getRecord(0).get("RETO_PARTY") )).add(
//								new BigDecimal((String) ds1.getRecord(0).get("PARTY_IN"))) );
//				ds1.getRecord(i).set("NEW_DOWN",new BigDecimal((String)ds.getRecord(0).get("OUT_PARTY")).add(
//						new BigDecimal( (String)ds.getRecord(0).get("STOP_PARTY") )).add(
//								new BigDecimal((String) ds.getRecord(0).get("DIE_PARTY"))).add(
//										new BigDecimal((String) ds1.getRecord(0).get("OUT_TISSUE"))) );
//				
//				ds1.getRecord(i).set("SHOULD_SUM",new BigDecimal((String)ds1.getRecord(0).get("NEW_SUM")).add(
//						new BigDecimal( (String)ds1.getRecord(0).get("NEW_SUM") )).subtract(
//								new BigDecimal((String) ds1.getRecord(0).get("NEW_DOWN"))));
//				ds1.getRecord(i).set("BALANCE_SUM", 
//						new BigDecimal((String) ds1.getRecord(0).get("YEAR_REALLY")).subtract(
//								new BigDecimal((String) ds1.getRecord(0).get("SHOULD_SUM"))) );
			}
		}
		return ds1;
	}
	/**
	 * 关联查询党员变动
	 * @param ifLike
	 * @param morgArea
	 */
	private DataSet queryMemberTwoYearChange(String ifLike, String morgArea) {
		StringBuffer sql=new StringBuffer();
		sql.append(" select  ");
		//恢复党籍
		sql.append(" sum(case when c.change_type='5' and c.change_time like to_char(sysdate, 'yyyy')||'%' then 1 else 0 end)reto_party,  ");
		//出党
		sql.append(" sum(case when c.change_type='0' and c.change_time like to_char(sysdate, 'yyyy')||'%' then 1 else 0 end)out_party,  ");
		//停止党籍
		sql.append(" sum(case when c.change_type='1' and c.change_time like to_char(sysdate, 'yyyy')||'%' then 1 else 0 end)stop_party,  ");
		//死亡
		sql.append(" sum(case when c.change_type='2' and c.change_time like to_char(sysdate, 'yyyy')||'%' then 1 else 0 end)die_party  ");
		
		sql.append(" from som_party_member t,som_party_member_status_change c where t.member_id=c.member_id(+)  and t.morg_area ");
		
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		typeList.add(Types.VARCHAR);
		if("1".equals(ifLike)){
			sql.append(" like ?");
			argsList.add(getAreaCodeLikePrefix(morgArea)+"%");
		}else{
			sql.append(" = ? ");
			argsList.add(morgArea);
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		return executeDataset(sql.toString(), types, args,  true);
	}
	/**
	 * 党员基本情况
	 * @param pset
	 * @return
	 */
	public DataSet queryBaseCase(ParameterSet pset) {
		StringBuffer sql=new StringBuffer();
		sql.append(" select  ");
		sql.append("  sum(case when substr(t.morg_area,3,10)='0000000000' and s.sorg_type='S' then 1 else 0 end ) province_s, ");
		sql.append("  sum(case when substr(t.morg_area,3,10)='0000000000' and s.sorg_type='M' then 1 else 0 end ) province_m, ");
		sql.append("  sum(case when substr(t.morg_area,3,10)='0000000000' and s.sorg_type='J' then 1 else 0 end ) province_j, ");
		
		sql.append("  sum(case when substr(t.morg_area,5,10)='00000000' and substr(t.morg_area,3,10) !='0000000000' and s.sorg_type='S' then 1 else 0 end ) city_s, ");
		sql.append("  sum(case when substr(t.morg_area,5,10)='00000000' and substr(t.morg_area,3,10) !='0000000000' and s.sorg_type='M' then 1 else 0 end ) city_m, ");
		sql.append("  sum(case when substr(t.morg_area,5,10)='00000000' and substr(t.morg_area,3,10) !='0000000000' and s.sorg_type='J' then 1 else 0 end ) city_j, ");   
		
		sql.append("  sum(case when substr(t.morg_area,7,10)='000000'and substr(t.morg_area,5,10)!='00000000' and substr(t.morg_area,3,10) !='0000000000' and s.sorg_type='S' then 1 else 0 end ) country_s, ");
		sql.append("  sum(case when substr(t.morg_area,7,10)='000000'and substr(t.morg_area,5,10)!='00000000' and substr(t.morg_area,3,10) !='0000000000' and s.sorg_type='M' then 1 else 0 end ) country_m, ");
		sql.append("  sum(case when substr(t.morg_area,7,10)='000000'and substr(t.morg_area,5,10)!='00000000' and substr(t.morg_area,3,10) !='0000000000' and s.sorg_type='J' then 1 else 0 end ) country_j ");
	
		sql.append("  from som_party_member t, som_organ s ");
		sql.append("   where t.sorg_id = s.sorg_id(+)  ");
		return executeDataset(sql.toString(), true);
	}
	
	/**
	 * 党员入党时间情况
	 * @param pset
	 * @return
	 */
	public DataSet queryNormalDate(ParameterSet pset) {
		String ifLike=(String)pset.getParameter("ifLike");
		String morgArea=BspUtil.getCorpOrgan().getOrganCode();
		StringBuffer sql=new StringBuffer();
		sql.append(" select  ");
		sql.append("  sum(case when  normal_date<='1937-07-06' and s.sorg_type='S' then 1 else 0 end) area1937_S, ");
		sql.append("  sum(case when  normal_date<='1937-07-06' and s.sorg_type='M' then 1 else 0 end) area1937_M, ");
		sql.append("  sum(case when  normal_date<='1937-07-06' and s.sorg_type='J' then 1 else 0 end) area1937_J, ");
		
		sql.append("  sum(case when  normal_date>='1937-07-07' and s.sorg_type='S' and normal_date<='1945-09-02' then 1 else 0 end) area1937to1945_S, ");
		sql.append("  sum(case when  normal_date>='1937-07-07' and s.sorg_type='M' and normal_date<='1945-09-02' then 1 else 0 end) area1937to1945_M, ");
		sql.append("  sum(case when  normal_date>='1937-07-07' and s.sorg_type='J' and normal_date<='1945-09-02' then 1 else 0 end) area1937to1945_J, ");
		
		sql.append("  sum(case when  normal_date>='1945-09-03' and normal_date<='1949-09-30' and s.sorg_type='S' then 1 else 0 end) area1945to1949_S, ");
		sql.append("  sum(case when  normal_date>='1945-09-03' and normal_date<='1949-09-30' and s.sorg_type='M' then 1 else 0 end) area1945to1949_M, ");
		sql.append("  sum(case when  normal_date>='1945-09-03' and normal_date<='1949-09-30' and s.sorg_type='J' then 1 else 0 end) area1945to1949_J, ");
		
		sql.append("  sum(case when  normal_date>='1949-10-01' and normal_date<='1966-04-30' and s.sorg_type='S' then 1 else 0 end) area1949to1966_S, ");
		sql.append("  sum(case when  normal_date>='1949-10-01' and normal_date<='1966-04-30' and s.sorg_type='M' then 1 else 0 end) area1949to1966_M, ");
		sql.append("  sum(case when  normal_date>='1949-10-01' and normal_date<='1966-04-30' and s.sorg_type='J' then 1 else 0 end) area1949to1966_J, ");
		
		sql.append("  sum(case when  normal_date>='1966-05-01' and normal_date<='1976-10-31' and s.sorg_type='S' then 1 else 0 end) area1966to1976_S, ");
		sql.append("  sum(case when  normal_date>='1966-05-01' and normal_date<='1976-10-31' and s.sorg_type='M' then 1 else 0 end) area1966to1976_M, ");
		sql.append("  sum(case when  normal_date>='1966-05-01' and normal_date<='1976-10-31' and s.sorg_type='J' then 1 else 0 end) area1966to1976_J, ");
		
		sql.append("  sum(case when  normal_date>='1976-11-01' and normal_date<='1978-12-31' and s.sorg_type='S' then 1 else 0 end) area1976to1978_S, ");   
		sql.append("  sum(case when  normal_date>='1976-11-01' and normal_date<='1978-12-31' and s.sorg_type='M' then 1 else 0 end) area1976to1978_M, ");   
		sql.append("  sum(case when  normal_date>='1976-11-01' and normal_date<='1978-12-31' and s.sorg_type='J' then 1 else 0 end) area1976to1978_J, ");
		
		sql.append("  sum(case when  normal_date>='1979-01-01' and normal_date<='2002-10-31' and s.sorg_type='S' then 1 else 0 end) area1979to2002_S, ");
		sql.append("  sum(case when  normal_date>='1979-01-01' and normal_date<='2002-10-31' and s.sorg_type='M' then 1 else 0 end) area1979to2002_M, ");
		sql.append("  sum(case when  normal_date>='1979-01-01' and normal_date<='2002-10-31' and s.sorg_type='J' then 1 else 0 end) area1979to2002_J, ");
		
		sql.append("  sum(case when  normal_date>='2002-11-01' and s.sorg_type='S'  then 1 else 0 end) area2002_S, ");
		sql.append("  sum(case when  normal_date>='2002-11-01' and s.sorg_type='M'  then 1 else 0 end) area2002_M, ");
		sql.append("  sum(case when  normal_date>='2002-11-01' and s.sorg_type='J'  then 1 else 0 end) area2002_J, ");
		
		sql.append("  sum(case when  normal_date>='2007-11-01' and s.sorg_type='S'  then 1 else 0 end) area2007_S, ");
		sql.append("  sum(case when  normal_date>='2007-11-01' and s.sorg_type='M'  then 1 else 0 end) area2007_M,");
		sql.append("  sum(case when  normal_date>='2007-11-01' and s.sorg_type='J'  then 1 else 0 end) area2007_J ");
		
		sql.append("  from som_party_member t, som_organ s ");
		sql.append("   where t.sorg_id = s.sorg_id(+)  and t.morg_area");
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		typeList.add(Types.VARCHAR);
		if("1".equals(ifLike)){
			sql.append(" like ?");
			argsList.add(getAreaCodeLikePrefix(morgArea)+"%");
		}else{
			sql.append(" = ? ");
			argsList.add(morgArea);
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		return executeDataset(sql.toString(), types, args,  true);
	}
	
	/**
	 * 党员学历情况
	 * @param pset
	 * @return
	 */
	public DataSet queryEducation(ParameterSet pset) {
		String ifLike=(String)pset.getParameter("ifLike");
		String morgArea=BspUtil.getCorpOrgan().getOrganCode();
		StringBuffer sql=new StringBuffer();
		sql.append(" select  ");
		//研究生
		sql.append("  sum(case when t.education='10' and s.sorg_type='S' then 1 else 0 end ) yjs_s, ");
		sql.append("  sum(case when t.education='10' and s.sorg_type='M' then 1 else 0 end ) yjs_m, ");
		sql.append("  sum(case when t.education='10' and s.sorg_type='J' then 1 else 0 end ) yjs_j, ");
		//大学本科
		sql.append("  sum(case when t.education='20' and s.sorg_type='S' then 1 else 0 end ) dxbk_s, ");
		sql.append("  sum(case when t.education='20' and s.sorg_type='M' then 1 else 0 end ) dxbk_m, ");
		sql.append("  sum(case when t.education='20' and s.sorg_type='J' then 1 else 0 end ) dxbk_j, ");   
		//大学专科
		sql.append("  sum(case when t.education='30' and s.sorg_type='S' then 1 else 0 end ) dxzk_s, ");
		sql.append("  sum(case when t.education='30' and s.sorg_type='M' then 1 else 0 end ) dxzk_m, ");
		sql.append("  sum(case when t.education='30' and s.sorg_type='J' then 1 else 0 end ) dxzk_j, "); 
		//中专
		sql.append("  sum(case when t.education='40' and s.sorg_type='S' then 1 else 0 end ) zz_s, ");
		sql.append("  sum(case when t.education='40' and s.sorg_type='M' then 1 else 0 end ) zz_m, ");
		sql.append("  sum(case when t.education='40' and s.sorg_type='J' then 1 else 0 end ) zz_j, ");   
		//高中、中技
		sql.append("  sum(case when (t.education='50' or t.education='60') and s.sorg_type='S' then 1 else 0 end ) gz_s, ");
		sql.append("  sum(case when (t.education='50' or t.education='60') and s.sorg_type='M' then 1 else 0 end ) gz_m, ");
		sql.append("  sum(case when (t.education='50' or t.education='60') and s.sorg_type='J' then 1 else 0 end ) gz_j, ");   
		//初中及以下
		sql.append("  sum(case when (t.education='70' or t.education='80' or t.education='90' or t.education='99') and s.sorg_type='S' then 1 else 0 end ) cz_s, ");
		sql.append("  sum(case when (t.education='70' or t.education='80' or t.education='90' or t.education='99') and s.sorg_type='M' then 1 else 0 end ) cz_m, ");
		sql.append("  sum(case when (t.education='70' or t.education='80' or t.education='90' or t.education='99') and s.sorg_type='J' then 1 else 0 end ) cz_j ");   
		
		sql.append("  from som_party_member t, som_organ s ");
		sql.append("   where t.sorg_id = s.sorg_id(+)   and t.morg_area ");
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		typeList.add(Types.VARCHAR);
		if("1".equals(ifLike)){
			sql.append(" like ?");
			argsList.add(getAreaCodeLikePrefix(morgArea)+"%");
		}else{
			sql.append(" = ? ");
			argsList.add(morgArea);
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		return executeDataset(sql.toString(), types, args,  true);
	}
	
	/**
	 * 党员年龄情况
	 * @param pset
	 * @return
	 */
	public DataSet queryAge(ParameterSet pset) {
		String ifLike=(String)pset.getParameter("ifLike");
		String morgArea=BspUtil.getCorpOrgan().getOrganCode();
		StringBuffer sql=new StringBuffer();
		sql.append(" select  ");
		//35岁以下
		sql.append("  sum(case when getage(t.birthday)<35 and s.sorg_type='S' then 1 else 0 end ) AGE35_S, ");
		sql.append("  sum(case when getage(t.birthday)<35 and s.sorg_type='M' then 1 else 0 end ) AGE35_M, ");
		sql.append("  sum(case when getage(t.birthday)<35 and s.sorg_type='J' then 1 else 0 end ) AGE35_J, ");
		//35岁到59岁
		sql.append("  sum(case when getage(t.birthday)>=35 and getage(t.birthday)<60 and s.sorg_type='S' then 1 else 0 end ) AGE35TO60_S, ");
		sql.append("  sum(case when getage(t.birthday)>=35 and getage(t.birthday)<60 and s.sorg_type='M' then 1 else 0 end ) AGE35TO60_M, ");
		sql.append("  sum(case when getage(t.birthday)>=35 and getage(t.birthday)<60 and s.sorg_type='J' then 1 else 0 end ) AGE35TO60_J, ");   
		//60岁及以上
		sql.append("  sum(case when getage(t.birthday)>=60 and s.sorg_type='S' then 1 else 0 end ) AGE60_S, ");
		sql.append("  sum(case when getage(t.birthday)>=60 and s.sorg_type='M' then 1 else 0 end ) AGE60_M, ");
		sql.append("  sum(case when getage(t.birthday)>=60 and s.sorg_type='J' then 1 else 0 end ) AGE60_J  "); 
		
		sql.append("  from som_party_member t, som_organ s ");
		sql.append("   where t.sorg_id = s.sorg_id(+)   and t.morg_area ");
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		typeList.add(Types.VARCHAR);
		if("1".equals(ifLike)){
			sql.append(" like ?");
			argsList.add(getAreaCodeLikePrefix(morgArea)+"%");
		}else{
			sql.append(" = ? ");
			argsList.add(morgArea);
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		return executeDataset(sql.toString(), types, args,  true);
	}
	
	/**
	 * 党内表彰情况
	 * @param pset
	 * @return
	 */
	public DataSet queryPraise(ParameterSet pset) {
		String ifLike=(String)pset.getParameter("ifLike");
		String morgArea=BspUtil.getCorpOrgan().getOrganCode();
		StringBuffer sql=new StringBuffer();
		sql.append(" select  ");
		//抗灾救灾
		sql.append("  sum(case when s.GRANTED_TITLE='0' and s.PRAISE_ITEM_TYPE='3' then 1 else 0 end ) KZJZ_DZ, ");//先进党组织
		sql.append("  sum(case when s.GRANTED_TITLE='1' and s.PRAISE_ITEM_TYPE='3' then 1 else 0 end ) KZJZ_DY, ");//优秀共产党员
		sql.append("  sum(case when s.GRANTED_TITLE='2' and s.PRAISE_ITEM_TYPE='3' then 1 else 0 end ) KZJZ_DW, ");//优秀党务工作者
		//省（区、市）一级表彰
		sql.append("  sum(case when s.GRANTED_TITLE='0' and s.PRAISE_ITEM_TYPE='0' then 1 else 0 end ) S_DZ, ");//先进党组织
		sql.append("  sum(case when s.GRANTED_TITLE='1' and s.PRAISE_ITEM_TYPE='0' then 1 else 0 end ) S_DY, ");//优秀共产党员
		sql.append("  sum(case when s.GRANTED_TITLE='2' and s.PRAISE_ITEM_TYPE='0' then 1 else 0 end ) S_DW, ");//优秀党务工作者
		//市（地、州、盟）一级表彰
		sql.append("  sum(case when s.GRANTED_TITLE='0' and s.PRAISE_ITEM_TYPE='1' then 1 else 0 end ) D_DZ, ");//先进党组织
		sql.append("  sum(case when s.GRANTED_TITLE='1' and s.PRAISE_ITEM_TYPE='1' then 1 else 0 end ) D_DY, ");//优秀共产党员
		sql.append("  sum(case when s.GRANTED_TITLE='2' and s.PRAISE_ITEM_TYPE='1' then 1 else 0 end ) D_DW, ");//优秀党务工作者
		//县（市、区、旗）一级表彰
		sql.append("  sum(case when s.GRANTED_TITLE='0' and s.PRAISE_ITEM_TYPE='2' then 1 else 0 end ) X_DZ, ");//先进党组织
		sql.append("  sum(case when s.GRANTED_TITLE='1' and s.PRAISE_ITEM_TYPE='2' then 1 else 0 end ) X_DY, ");//优秀共产党员
		sql.append("  sum(case when s.GRANTED_TITLE='2' and s.PRAISE_ITEM_TYPE='2' then 1 else 0 end ) X_DW, ");//优秀党务工作者
		//其他表彰
		sql.append("  sum(case when s.GRANTED_TITLE='0' and s.PRAISE_ITEM_TYPE='4' then 1 else 0 end ) QT_DZ, ");//先进党组织
		sql.append("  sum(case when s.GRANTED_TITLE='1' and s.PRAISE_ITEM_TYPE='4' then 1 else 0 end ) QT_DY, ");//优秀共产党员
		sql.append("  sum(case when s.GRANTED_TITLE='2' and s.PRAISE_ITEM_TYPE='4' then 1 else 0 end ) QT_DW, ");//优秀党务工作者
		//本年度表彰的优秀共产党员中有党委（总支部、支部）书记      名
		sql.append("  sum(case when s.GRANTED_TITLE='1' and t.PARTY_DUTIES='' and s.PRAISE_DATE like '"+DateUtil.getYear()+"%' then 1 else 0 end ) DWSJ_DY, ");
		//表彰的优秀党务工作者中有党委（总支部、支部）书记      名
		sql.append("  sum(case when s.GRANTED_TITLE='2' and t.PARTY_DUTIES='' and s.PRAISE_DATE like '"+DateUtil.getYear()+"%' then 1 else 0 end ) DWSJ_DW, ");
		//本年度表彰的优秀共产党员中生活困难的      名
		sql.append("  sum(case when s.GRANTED_TITLE='1' and t.IF_POOR='1' and s.PRAISE_DATE like '"+DateUtil.getYear()+"%' then 1 else 0 end ) SHKN_DW, ");
		//表彰的优秀党务工作者中生活困难的      名
		sql.append("  sum(case when s.GRANTED_TITLE='2' and t.IF_POOR='1' and s.PRAISE_DATE like '"+DateUtil.getYear()+"%' then 1 else 0 end ) SHKN_DW, ");
		//本年度追授优秀共产党员      名
		sql.append("  sum(case when s.GRANTED_TITLE='1' and s.PRAISE_DATE like '"+DateUtil.getYear()+"%' then 1 else 0 end ) YEAR_DW, ");
		//表本年度追授优秀共产党员其中抗灾救灾追授      名
		sql.append("  sum(case when s.GRANTED_TITLE='1' and s.PRAISE_ITEM_TYPE='3' and s.PRAISE_DATE like '"+DateUtil.getYear()+"%' then 1 else 0 end ) YEAR_KZJZ_DW ");
		
		sql.append("  from som_party_member t, SOM_PARTY_PRAISE s ");
		sql.append("   where s.MEMBER_ID = t.MEMBER_ID(+)   and t.morg_area ");
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		typeList.add(Types.VARCHAR);
		if("1".equals(ifLike)){
			sql.append(" like ?");
			argsList.add(getAreaCodeLikePrefix(morgArea)+"%");
		}else{
			sql.append(" = ? ");
			argsList.add(morgArea);
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		System.out.println(sql.toString());
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		return executeDataset(sql.toString(), types, args,  true);
	}
	
	/**
	 * 发展党员情况
	 * @param pset
	 * @return
	 */
	public DataSet queryDevelop(ParameterSet pset) {
		String ifLike=(String)pset.getParameter("ifLike");
		String morgArea=BspUtil.getCorpOrgan().getOrganCode();
		StringBuffer sql=new StringBuffer();
		sql.append(" select  ");
		//发展党员女社团
		sql.append("  sum(case when t.SEX='2' and s.sorg_type='S' and t.PEOPLE_TYPE='3' then 1 else 0 end ) NV_S, ");
		//发展党员女民非
		sql.append("  sum(case when t.SEX='2' and s.sorg_type='M' and t.PEOPLE_TYPE='3' then 1 else 0 end ) NV_M, ");
		//发展党员女基金会
		sql.append("  sum(case when t.SEX='2' and s.sorg_type='J' and t.PEOPLE_TYPE='3' then 1 else 0 end ) NV_J, ");
		//少数民族
		sql.append("  sum(case when t.FOLK<>'01' and s.sorg_type='S' and t.PEOPLE_TYPE='3' then 1 else 0 end ) SSMZ_S, ");
		sql.append("  sum(case when t.FOLK<>'01' and s.sorg_type='M' and t.PEOPLE_TYPE='3' then 1 else 0 end ) SSMZ_M, ");
		sql.append("  sum(case when t.FOLK<>'01' and s.sorg_type='J' and t.PEOPLE_TYPE='3' then 1 else 0 end ) SSMZ_J, ");
		//年龄35岁及以下
		sql.append("  sum(case when getage(t.birthday)<=35 and s.sorg_type='S' and t.PEOPLE_TYPE='3' then 1 else 0 end ) AGE35_S, ");
		sql.append("  sum(case when getage(t.birthday)<=35 and s.sorg_type='M' and t.PEOPLE_TYPE='3' then 1 else 0 end ) AGE35_M, ");
		sql.append("  sum(case when getage(t.birthday)<=35 and s.sorg_type='J' and t.PEOPLE_TYPE='3' then 1 else 0 end ) AGE35_J,  "); 
		//36岁至59   岁
		sql.append("  sum(case when getage(t.birthday)>35 and getage(t.birthday)<=59 and s.sorg_type='S' and t.PEOPLE_TYPE='3' then 1 else 0 end ) AGE35TO59_S, ");
		sql.append("  sum(case when getage(t.birthday)>35 and getage(t.birthday)<=59 and s.sorg_type='M' and t.PEOPLE_TYPE='3' then 1 else 0 end ) AGE35TO59_M, ");
		sql.append("  sum(case when getage(t.birthday)>35 and getage(t.birthday)<=59 and s.sorg_type='J' and t.PEOPLE_TYPE='3' then 1 else 0 end ) AGE35TO59_J,  "); 
		//年龄60岁及以上
		sql.append("  sum(case when getage(t.birthday)>=60 and s.sorg_type='S' and t.PEOPLE_TYPE='3' then 1 else 0 end ) AGE60_S, ");
		sql.append("  sum(case when getage(t.birthday)>=60 and s.sorg_type='M' and t.PEOPLE_TYPE='3' then 1 else 0 end ) AGE60_M, ");
		sql.append("  sum(case when getage(t.birthday)>=60 and s.sorg_type='J' and t.PEOPLE_TYPE='3' then 1 else 0 end ) AGE60_J,  "); 
		
		//研究生
		sql.append("  sum(case when t.education='10' and s.sorg_type='S' and t.PEOPLE_TYPE='3' then 1 else 0 end ) YJS_S, ");
		sql.append("  sum(case when t.education='10' and s.sorg_type='M' and t.PEOPLE_TYPE='3' then 1 else 0 end ) YJS_M, ");
		sql.append("  sum(case when t.education='10' and s.sorg_type='J' and t.PEOPLE_TYPE='3' then 1 else 0 end ) YJS_J, ");
		//大学本科
		sql.append("  sum(case when t.education='20' and s.sorg_type='S' and t.PEOPLE_TYPE='3' then 1 else 0 end ) DXBK_S, ");
		sql.append("  sum(case when t.education='20' and s.sorg_type='M' and t.PEOPLE_TYPE='3' then 1 else 0 end ) DXBK_M, ");
		sql.append("  sum(case when t.education='20' and s.sorg_type='J' and t.PEOPLE_TYPE='3' then 1 else 0 end ) DXBK_J, ");   
		//大学专科
		sql.append("  sum(case when t.education='30' and s.sorg_type='S' and t.PEOPLE_TYPE='3' then 1 else 0 end ) DXZK_S, ");
		sql.append("  sum(case when t.education='30' and s.sorg_type='M' and t.PEOPLE_TYPE='3' then 1 else 0 end ) DXZK_M, ");
		sql.append("  sum(case when t.education='30' and s.sorg_type='J' and t.PEOPLE_TYPE='3' then 1 else 0 end ) DXZK_J, "); 
		//中专
		sql.append("  sum(case when t.education='40' and s.sorg_type='S' and t.PEOPLE_TYPE='3' then 1 else 0 end ) ZZ_S, ");
		sql.append("  sum(case when t.education='40' and s.sorg_type='M' and t.PEOPLE_TYPE='3' then 1 else 0 end ) ZZ_M, ");
		sql.append("  sum(case when t.education='40' and s.sorg_type='J' and t.PEOPLE_TYPE='3' then 1 else 0 end ) ZZ_J, ");   
		//高中、中技
		sql.append("  sum(case when (t.education='50' or t.education='60') and t.PEOPLE_TYPE='3' and s.sorg_type='S' then 1 else 0 end ) GZ_S, ");
		sql.append("  sum(case when (t.education='50' or t.education='60') and t.PEOPLE_TYPE='3' and s.sorg_type='M' then 1 else 0 end ) GZ_M, ");
		sql.append("  sum(case when (t.education='50' or t.education='60') and t.PEOPLE_TYPE='3' and s.sorg_type='J' then 1 else 0 end ) GZ_J, ");   
		//初中及以下
		sql.append("  sum(case when (t.education='70' or t.education='80' or t.education='90' or t.education='99') and t.PEOPLE_TYPE='3' and s.sorg_type='S' then 1 else 0 end ) CZ_S, ");
		sql.append("  sum(case when (t.education='70' or t.education='80' or t.education='90' or t.education='99') and t.PEOPLE_TYPE='3' and s.sorg_type='M' then 1 else 0 end ) CZ_M, ");
		sql.append("  sum(case when (t.education='70' or t.education='80' or t.education='90' or t.education='99') and t.PEOPLE_TYPE='3' and s.sorg_type='J' then 1 else 0 end ) CZ_J ");   
		
		
		sql.append("  from som_party_member t, som_organ s ");
		sql.append("   where t.sorg_id = s.sorg_id(+)   and t.morg_area ");
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		typeList.add(Types.VARCHAR);
		if("1".equals(ifLike)){
			sql.append(" like ?");
			argsList.add(getAreaCodeLikePrefix(morgArea)+"%");
		}else{
			sql.append(" = ? ");
			argsList.add(morgArea);
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		return executeDataset(sql.toString(), types, args,  true);
	}
	
	/**
	 * 预备党员情况
	 * @param pset
	 * @return
	 */
	public DataSet queryJoin(ParameterSet pset) {
		String ifLike=(String)pset.getParameter("ifLike");
		String morgArea=BspUtil.getCorpOrgan().getOrganCode();
		StringBuffer sql=new StringBuffer();
		sql.append(" select  ");
		//发展党员女社团
		sql.append("  sum(case when t.SEX='2' and s.sorg_type='S' and t.PEOPLE_TYPE='2' then 1 else 0 end ) NV_S, ");
		//发展党员女民非
		sql.append("  sum(case when t.SEX='2' and s.sorg_type='M' and t.PEOPLE_TYPE='2' then 1 else 0 end ) NV_M, ");
		//发展党员女基金会
		sql.append("  sum(case when t.SEX='2' and s.sorg_type='J' and t.PEOPLE_TYPE='2' then 1 else 0 end ) NV_J, ");
		//少数民族
		sql.append("  sum(case when t.FOLK<>'01' and s.sorg_type='S' and t.PEOPLE_TYPE='2' then 1 else 0 end ) SSMZ_S, ");
		sql.append("  sum(case when t.FOLK<>'01' and s.sorg_type='M' and t.PEOPLE_TYPE='2' then 1 else 0 end ) SSMZ_M, ");
		sql.append("  sum(case when t.FOLK<>'01' and s.sorg_type='J' and t.PEOPLE_TYPE='2' then 1 else 0 end ) SSMZ_J, ");
		//年龄35岁及以下
		sql.append("  sum(case when getage(t.birthday)<=35 and s.sorg_type='S' and t.PEOPLE_TYPE='2' then 1 else 0 end ) AGE35_S, ");
		sql.append("  sum(case when getage(t.birthday)<=35 and s.sorg_type='M' and t.PEOPLE_TYPE='2' then 1 else 0 end ) AGE35_M, ");
		sql.append("  sum(case when getage(t.birthday)<=35 and s.sorg_type='J' and t.PEOPLE_TYPE='2' then 1 else 0 end ) AGE35_J,  "); 
		//36岁至59   岁
		sql.append("  sum(case when getage(t.birthday)>35 and getage(t.birthday)<=59 and s.sorg_type='S' and t.PEOPLE_TYPE='2' then 1 else 0 end ) AGE35TO59_S, ");
		sql.append("  sum(case when getage(t.birthday)>35 and getage(t.birthday)<=59 and s.sorg_type='M' and t.PEOPLE_TYPE='2' then 1 else 0 end ) AGE35TO59_M, ");
		sql.append("  sum(case when getage(t.birthday)>35 and getage(t.birthday)<=59 and s.sorg_type='J' and t.PEOPLE_TYPE='2' then 1 else 0 end ) AGE35TO59_J,  "); 
		//年龄60岁及以上
		sql.append("  sum(case when getage(t.birthday)>=60 and s.sorg_type='S' and t.PEOPLE_TYPE='2' then 1 else 0 end ) AGE60_S, ");
		sql.append("  sum(case when getage(t.birthday)>=60 and s.sorg_type='M' and t.PEOPLE_TYPE='2' then 1 else 0 end ) AGE60_M, ");
		sql.append("  sum(case when getage(t.birthday)>=60 and s.sorg_type='J' and t.PEOPLE_TYPE='2' then 1 else 0 end ) AGE60_J,  "); 
		
		//研究生
		sql.append("  sum(case when t.education='10' and s.sorg_type='S' and t.PEOPLE_TYPE='2' then 1 else 0 end ) YJS_S, ");
		sql.append("  sum(case when t.education='10' and s.sorg_type='M' and t.PEOPLE_TYPE='2' then 1 else 0 end ) YJS_M, ");
		sql.append("  sum(case when t.education='10' and s.sorg_type='J' and t.PEOPLE_TYPE='2' then 1 else 0 end ) YJS_J, ");
		//大学本科
		sql.append("  sum(case when t.education='20' and s.sorg_type='S' and t.PEOPLE_TYPE='2' then 1 else 0 end ) DXBK_S, ");
		sql.append("  sum(case when t.education='20' and s.sorg_type='M' and t.PEOPLE_TYPE='2' then 1 else 0 end ) DXBK_M, ");
		sql.append("  sum(case when t.education='20' and s.sorg_type='J' and t.PEOPLE_TYPE='2' then 1 else 0 end ) DXBK_J, ");   
		//大学专科
		sql.append("  sum(case when t.education='30' and s.sorg_type='S' and t.PEOPLE_TYPE='2' then 1 else 0 end ) DXZK_S, ");
		sql.append("  sum(case when t.education='30' and s.sorg_type='M' and t.PEOPLE_TYPE='2' then 1 else 0 end ) DXZK_M, ");
		sql.append("  sum(case when t.education='30' and s.sorg_type='J' and t.PEOPLE_TYPE='2' then 1 else 0 end ) DXZK_J, "); 
		//中专
		sql.append("  sum(case when t.education='40' and s.sorg_type='S' and t.PEOPLE_TYPE='2' then 1 else 0 end ) ZZ_S, ");
		sql.append("  sum(case when t.education='40' and s.sorg_type='M' and t.PEOPLE_TYPE='2' then 1 else 0 end ) ZZ_M, ");
		sql.append("  sum(case when t.education='40' and s.sorg_type='J' and t.PEOPLE_TYPE='2' then 1 else 0 end ) ZZ_J, ");   
		//高中、中技
		sql.append("  sum(case when (t.education='50' or t.education='60') and t.PEOPLE_TYPE='2' and s.sorg_type='S' then 1 else 0 end ) GZ_S, ");
		sql.append("  sum(case when (t.education='50' or t.education='60') and t.PEOPLE_TYPE='2' and s.sorg_type='M' then 1 else 0 end ) GZ_M, ");
		sql.append("  sum(case when (t.education='50' or t.education='60') and t.PEOPLE_TYPE='2' and s.sorg_type='J' then 1 else 0 end ) GZ_J, ");   
		//初中及以下
		sql.append("  sum(case when (t.education='70' or t.education='80' or t.education='90' or t.education='99') and t.PEOPLE_TYPE='2' and s.sorg_type='S' then 1 else 0 end ) CZ_S, ");
		sql.append("  sum(case when (t.education='70' or t.education='80' or t.education='90' or t.education='99') and t.PEOPLE_TYPE='2' and s.sorg_type='M' then 1 else 0 end ) CZ_M, ");
		sql.append("  sum(case when (t.education='70' or t.education='80' or t.education='90' or t.education='99') and t.PEOPLE_TYPE='2' and s.sorg_type='J' then 1 else 0 end ) CZ_J ");   
		
		
		sql.append("  from som_party_member t, som_organ s ");
		sql.append("   where t.sorg_id = s.sorg_id(+)   and t.morg_area ");
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		typeList.add(Types.VARCHAR);
		if("1".equals(ifLike)){
			sql.append(" like ?");
			argsList.add(getAreaCodeLikePrefix(morgArea)+"%");
		}else{
			sql.append(" = ? ");
			argsList.add(morgArea);
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		return executeDataset(sql.toString(), types, args,  true);
	}
	
	private String getAreaCodeLikePrefix(String areaCode) {
        if(areaCode.endsWith("0000000000")){//省370000000000
			return areaCode.substring(0,2);
		} else if (areaCode.endsWith("00000000")){//市370100000000
			return areaCode.substring(0,4);
		} else if (areaCode.endsWith("000000")){//县370104000000
			return areaCode.substring(0,6);
		} else if (areaCode.endsWith("000")){//乡370104003000
			return areaCode.substring(0,9);
		}
        return areaCode;
	}
}
