package com.inspur.cams.drel.funds.release.dao.support;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.commons.lang.StringUtils;
import org.loushang.persistent.jdbc.core.ResultReader;
import org.loushang.persistent.jdbc.core.SqlParameter;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.persistent.jdbc.object.Procedure;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.ExportExcelPageUtil;
import com.inspur.cams.comm.util.ProceduresUtil;
import com.inspur.cams.comm.util.ProceduresUtil.Proc;
import com.inspur.cams.drel.funds.release.dao.ISamReleaseSummaryDao;
import com.inspur.cams.drel.funds.release.data.SamReleaseSummary;

/**
 * @title:SamReleaseSummaryDao
 * @description:
 * @author:
 * @since:2012-05-07
 * @version:1.0
 */
public class SamReleaseSummaryDao extends EntityDao<SamReleaseSummary> implements ISamReleaseSummaryDao{

	public SamReleaseSummaryDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return SamReleaseSummary.class;
	}
	public void deleteStruAll() {
		executeUpdate("delete from SamReleaseSummary");
	}

	public void makeReleaseList(SamReleaseSummary releaseSummary) {
		SamReleaseMakeProc samReleaseMakeProc = new SamReleaseMakeProc(getDataSource());
		samReleaseMakeProc.call(releaseSummary.getReleaseId(),
				releaseSummary.getAssistanceType(), 
				releaseSummary.getReleaseType(), 
				releaseSummary.getReleaseWay(), 
				releaseSummary.getReleaseDate(), 
				releaseSummary.getReleaseAreaCode());
	}

	public void refreshSummary(String releaseId) {
		SamReleaseCalProc samReleaseCalProc = new SamReleaseCalProc(getDataSource());
		samReleaseCalProc.call(releaseId);
	}
	/**
	 * 调用名称生成存储过程
	 * @author jiangyabo
	 *
	 */
	private static class SamReleaseMakeProc extends Procedure {
		public SamReleaseMakeProc(DataSource ds) {
			super(ds, "SAM_RELEASE_MAKE");
			// 声明六个入参和一个出参
			// 声明的参数必须有参数名
			declareParameter(new SqlParameter("releaseId", Types.VARCHAR));
			declareParameter(new SqlParameter("assistanceType", Types.VARCHAR));
			declareParameter(new SqlParameter("releaseType", Types.VARCHAR));
			declareParameter(new SqlParameter("releaseWay", Types.VARCHAR));
			declareParameter(new SqlParameter("releaseDate", Types.VARCHAR));
			declareParameter(new SqlParameter("releaseAreaCode", Types.VARCHAR));
			// 声明结果集的个数
			setNumberOfResultSet(0);
			compile();
		}
		public Map call(String releaseId,String assistanceType,String releaseType,String releaseWay,String releaseDate,String releaseAreaCode) {
			Map<String,Object> in = new HashMap<String,Object> ();
			in.put("releaseId", releaseId);// 设置入参的值，key要和声明参数的名称一致
			in.put("assistanceType", assistanceType);
			in.put("releaseType", releaseType);
			in.put("releaseWay", releaseWay);
			in.put("releaseDate", releaseDate);
			in.put("releaseAreaCode", releaseAreaCode);
			// 通过匿名内部类构造3个结果集处理器
			// 数量要和声明的结果集的个数一致
			// 注意顺序
			ResultReader dicCityReader = new ResultReaderImpl() {
				// 处理数据库记录，这里只是简单的将一条记录映射成一个Map
				protected Object mapRow(ResultSet rs, int rowNum)
						throws SQLException {
					HashMap map = new HashMap();
					return map;
				}
			};			
			//可以多个
			ResultReader[] readerA = new ResultReader[] { dicCityReader };

			// 执行调用，出参都在返回的ret变量里，其中key是参数名，value是对应的参数值(java.lang.Object类型)
			Map ret = execute(in);
			// 可以通过结果集处理器的getResults()方法获得List
			//ret.put("dicCityList", dicCityReader.getResults());
			return ret;
		}
	}

	/**
	 * 调用名称生成存储过程
	 * @author jiangyabo
	 *
	 */
	private static class SamReleaseCalProc extends Procedure {
		public SamReleaseCalProc(DataSource ds) {
			super(ds, "SAM_RELEASE_CAL");
			// 声明六个入参和一个出参
			// 声明的参数必须有参数名
			declareParameter(new SqlParameter("releaseId", Types.VARCHAR));
			// 声明结果集的个数
			setNumberOfResultSet(0);
			compile();
		}
		public Map call(String releaseId) {
			Map<String,Object> in = new HashMap<String,Object> ();
			in.put("releaseId", releaseId);// 设置入参的值，key要和声明参数的名称一致
			// 通过匿名内部类构造3个结果集处理器
			// 数量要和声明的结果集的个数一致
			// 注意顺序
			ResultReader dicCityReader = new ResultReaderImpl() {
				// 处理数据库记录，这里只是简单的将一条记录映射成一个Map
				protected Object mapRow(ResultSet rs, int rowNum)
						throws SQLException {
					HashMap map = new HashMap();
					return map;
				}
			};			
			//可以多个
			ResultReader[] readerA = new ResultReader[] { dicCityReader };

			// 执行调用，出参都在返回的ret变量里，其中key是参数名，value是对应的参数值(java.lang.Object类型)
			Map ret = execute(in);
			// 可以通过结果集处理器的getResults()方法获得List
			//ret.put("dicCityList", dicCityReader.getResults());
			return ret;
		}

	}
	
	public void confirm(String releaseId, String status) {
		executeUpdate("update sam_release_summary set release_status='"+status+"' where release_id='"+releaseId+"'");
	}

	/**
	* @Title: deleteBySQL
	* @Description: TODO(删除专项救助)
	* @param set void  
	* @throws
	* @author luguosui
	 */
	public void deleteBySQL(ParameterSet set) {
		StringBuffer sql=new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objsList = new ArrayList<String>();
		String delIds=(String)set.getParameter("delIds");
		if(StringUtils.isNotEmpty(delIds)){
		sql.append(" delete SAM_RELEASE_SUMMARY S where 1=1");
			   	sql.append(" AND S.RELEASE_ID IN (");
				String[] ary = delIds.split(",");
				for (int i = 0; i < ary.length; i++) {
					sql.append(" ? ");
					if(i!=ary.length-1){
						sql.append(" , ");
					}
					typeList.add(Types.VARCHAR);
					objsList.add(ary[i]);
				}
				sql.append(" ) ");
		   }
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			this.executeUpdate(sql.toString(), types, args);
		} else {
			this.executeUpdate(sql.toString());
		}
	}

	/**
	* @Title: updateStatusByReleaseId
	* @Description: TODO(更新计划状态)
	* @param set void  
	* @throws
	* @author luguosui
	 */
	public void updateStatusByReleaseId(ParameterSet set) {
		String releaseId=(String)set.get("releaseId");
		if(StringUtils.isNotEmpty(releaseId)){
			StringBuffer sql=new StringBuffer();
			String releaseStatus=(String)set.get("releaseStatus");
			sql.append(" update SAM_RELEASE_SUMMARY set RELEASE_STATUS=?,MOD_ID=?,MOD_TIME=? where RELEASE_ID=? ");
			this.executeUpdate(sql.toString(), new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR}, new Object[]{releaseStatus,BspUtil.getEmpOrganId(),DateUtil.getTime(),releaseId});
		}
	}

	/**
	* @Title: updateAssistanceMon
	* @Description: TODO(更新救助金额相关信息)
	* @param releaseId void  
	* @throws
	* @author luguosui
	 */
	public void updateAssistanceMon(String releaseId) {
		StringBuffer sql=new StringBuffer();
		sql.append("  update sam_release_summary s ");
		sql.append("  set s.release_family_sum=(select count(1) from sam_release_detail where release_id=?), ");
		sql.append("  s.release_fund_sum=(select sum(release_mon_sum) from sam_release_detail where release_id=?), ");
		sql.append("    s.release_people_num=(select sum(assistance_people_num) from sam_release_detail where release_id=?), ");
		sql.append("  s.base_mon_sum=(select sum(base_mon) from sam_release_detail where release_id=?), ");
		sql.append(" s.class_mon_sum=(select sum(class_mon) from sam_release_detail where release_id=?), ");
		sql.append("    s.release_status='01' ");
		sql.append("  where release_id=? ");
		this.executeUpdate(sql.toString(), new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR}, new Object[]{releaseId,releaseId,releaseId,releaseId,releaseId,releaseId});
	}
	public void batchDel(String[] fkId) {
		String[] sql = new String[fkId.length];
		for (int i = 0; i < fkId.length; i++) {
			sql[i] = "delete from SAM_RELEASE_SUMMARY where detail_id='" + fkId[i] + "'";
		}
		batchUpdate(sql);
	}

	/**
	* @Title: queryReleaseStat
	* @Description: TODO(资金发放统计)
	* @param pset
	* @return DataSet  
	* @throws
	* @author luguosui
	 */
	public DataSet queryReleaseStat(ParameterSet pset) {
	   StringBuffer sql=new StringBuffer(); 
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
       String beginDate=(String)pset.getParameter("beginDate");
       String endDate=(String)pset.getParameter("endDate");
       String releaseArea=(String)pset.getParameter("releaseArea");
       String assistanceType=(String)pset.getParameter("assistanceType");
       String isSpecial=(String)pset.getParameter("isSpecial");
       sql.append(" select d.id,d.Name,al.* from dic_city d left join( ");
	   sql.append("select ");
	   sql.append(" rpad(substr(RELEASE_AREA, 1, "+getSubstrIndex(releaseArea)+"), 12, '0') RELEASE_AREA,GET_CITYNAME(rpad(substr(RELEASE_AREA, 1, "+getSubstrIndex(releaseArea)+"), 12, '0') ) RELEASE_AREA_NAME,");
       sql.append("sum(nvl(S.RELEASE_FAMILY_SUM,0))-sum(nvl(S.TOWN_FAMILY_SUM,0)) RELEASE_FAMILY_SUM,");
       sql.append("sum(nvl(S.CENTRAL_FAMILY_SUM,0)) CENTRAL_FAMILY_SUM,");
       sql.append("sum(nvl(S.PROVINCE_FAMILY_SUM,0)) PROVINCE_FAMILY_SUM,");
       sql.append("sum(nvl(S.CITY_FAMILY_SUM,0)) CITY_FAMILY_SUM,");
       sql.append("sum(nvl(S.COUNTY_FAMILY_SUM,0)) COUNTY_FAMILY_SUM,");
       sql.append("sum(nvl(S.TOWN_FAMILY_SUM,0)) TOWN_FAMILY_SUM,");
      
       sql.append("sum(nvl(S.RELEASE_PEOPLE_SUM,0))-sum(nvl(S.TOWN_PEOPLE_SUM,0)) RELEASE_PEOPLE_SUM,");
       sql.append("sum(nvl(S.CENTRAL_PEOPLE_SUM,0)) CENTRAL_PEOPLE_SUM,");
       sql.append("sum(nvl(S.PROVINCE_PEOPLE_SUM,0)) PROVINCE_PEOPLE_SUM,");
       sql.append("sum(nvl(S.CITY_PEOPLE_SUM,0)) CITY_PEOPLE_SUM,");
       sql.append("sum(nvl(S.COUNTY_PEOPLE_SUM,0)) COUNTY_PEOPLE_SUM,");
       sql.append("sum(nvl(S.TOWN_PEOPLE_SUM,0)) TOWN_PEOPLE_SUM,");
      
       sql.append("sum(nvl(S.RELEASE_MON_SUM,0))-sum(nvl(S.TOWN_MATCHING_MON,0)) RELEASE_MON_SUM,");
       sql.append("sum(nvl(S.CENTRAL_MATCHING_MON,0)) CENTRAL_MATCHING_MON,");
       sql.append("sum(nvl(S.PROVINCE_MATCHING_MON,0)) PROVINCE_MATCHING_MON,");
       sql.append("sum(nvl(S.CITY_MATCHING_MON,0)) CITY_MATCHING_MON,");
       sql.append("sum(nvl(S.COUNTY_MATCHING_MON,0)) COUNTY_MATCHING_MON,");
       sql.append("sum(nvl(S.TOWN_MATCHING_MON,0)) TOWN_MATCHING_MON,");
      
       sql.append("sum(nvl(S.ASSISTANCE_MON_SUM,0))-sum(nvl(S.TOWN_ASSISTANCE_MON,0)) ASSISTANCE_MON_SUM,");
       sql.append("sum(nvl(S.CENTRAL_ASSISTANCE_MON,0)) CENTRAL_ASSISTANCE_MON,");
       sql.append("sum(nvl(S.PROVINCE_ASSISTANCE_MON,0)) PROVINCE_ASSISTANCE_MON,");
       sql.append("sum(nvl(S.CITY_ASSISTANCE_MON,0)) CITY_ASSISTANCE_MON,");
       sql.append("sum(nvl(S.COUNTY_ASSISTANCE_MON,0)) COUNTY_ASSISTANCE_MON,");
       sql.append("sum(nvl(S.TOWN_ASSISTANCE_MON,0)) TOWN_ASSISTANCE_MON,");
      
       sql.append("sum(nvl(S.ASSISTANCE_CLASS_MON_SUM,0))-sum(nvl(S.TOWN_CLASS_MON,0)) ASSISTANCE_CLASS_MON_SUM,");
       sql.append("sum(nvl(S.CENTRAL_CLASS_MON,0)) CENTRAL_CLASS_MON,");
       sql.append("sum(nvl(S.PROVINCE_CLASS_MON,0)) PROVINCE_CLASS_MON,");
       sql.append("sum(nvl(S.CITY_CLASS_MON,0)) CITY_CLASS_MON,");
       sql.append("sum(nvl(S.COUNTY_CLASS_MON,0)) COUNTY_CLASS_MON,");
       sql.append("sum(nvl(S.TOWN_CLASS_MON,0)) TOWN_CLASS_MON ");
       sql.append("from sam_release_stat s where 1=1 ");
       if (StringUtils.isNotEmpty(beginDate)) {
		sql.append(" and s.RELEASE_DATE =? ");
		argsList.add(beginDate);
		typeList.add(Types.VARCHAR);
       }
//       if (StringUtils.isNotEmpty(endDate)) {
//   		sql.append(" and s.RELEASE_DATE <=? ");
//		argsList.add(endDate);
//		typeList.add(Types.VARCHAR);
//       
//       }
       if (StringUtils.isNotEmpty(isSpecial)) {
      		sql.append(" and S.IS_SPECIAL =? ");
   		argsList.add(isSpecial);
   		typeList.add(Types.VARCHAR);
          
        }
       if(StringUtils.isNotEmpty(assistanceType)){
		   	sql.append(" AND S.ASSISTANCE_TYPE IN (");
			String[] ary = assistanceType.split(",");
			for (int i = 0; i < ary.length; i++) {
				sql.append(" ? ");
				if(i!=ary.length-1){
					sql.append(" , ");
				}
				typeList.add(Types.VARCHAR);
				argsList.add(ary[i]);
			}
			sql.append(" ) ");
	   }
       if (StringUtils.isNotEmpty(releaseArea)) {
      		sql.append(" and s.RELEASE_AREA like ? ");
      		argsList.add(getAreaCodeLikePrefix(releaseArea)+"%");
      		typeList.add(Types.VARCHAR);
          
          }
       sql.append("group by rpad(substr(RELEASE_AREA, 1, "+getSubstrIndex(releaseArea)+"), 12, '0') ,GET_CITYNAME(rpad(substr(RELEASE_AREA, 1, "+getSubstrIndex(releaseArea)+"), 12, '0'))");
       sql.append("  ) al on  al.RELEASE_AREA=d.id ");
       sql.append("  where d.id = rpad(substr(d.id, 1, "+getSubstrIndex(releaseArea)+"), 12, '0') ");
       if (StringUtils.isNotEmpty(releaseArea)) {
    	   if(releaseArea.endsWith("000")){
		    	sql.append(" and d.ups=?  " );
		   } else {
		    	sql.append(" and d.id=?  " );
		   }
    		typeList.add(Types.VARCHAR);
      		argsList.add(releaseArea);
       }
       sql.append(" order by d.id ");
       DataSet ds=new DataSet();
       if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args,true);
		} else {
			ds = this.executeDataset(sql.toString(), true);
		}
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
	/**
	* @Title: queryReleaseMoneyStat
	* @Description: TODO(保障金统计查询方法)
	* @param pset
	* @return DataSet  
	* @throws
	* @author luguosui
	 */
	public DataSet queryReleaseMoneyStat(ParameterSet pset) {
		 StringBuffer sql=new StringBuffer(); 
			List<Integer> typeList = new ArrayList<Integer>();
			List<Object> argsList = new ArrayList<Object>();
	       String beginDate=(String)pset.getParameter("beginDate");
	       String endDate=(String)pset.getParameter("endDate");
	       String releaseArea=(String)pset.getParameter("releaseArea");
	       String assistanceType=(String)pset.getParameter("assistanceType");
	       String isSpecial=(String)pset.getParameter("isSpecial");
	       sql.append(" select d.id,d.Name,al.* from dic_city d left join( ");
		   sql.append("select ");
		   sql.append(" rpad(substr(RELEASE_AREA, 1, "+getSubstrIndex(releaseArea)+"), 12, '0') RELEASE_AREA,GET_CITYNAME(rpad(substr(RELEASE_AREA, 1, "+getSubstrIndex(releaseArea)+"), 12, '0') ) RELEASE_AREA_NAME,");
	       sql.append("sum(nvl(S.RELEASE_FAMILY_SUM,0)) RELEASE_FAMILY_SUM,");
	       sql.append("sum(nvl(S.CENTRAL_FAMILY_SUM,0)) CENTRAL_FAMILY_SUM,");
	       sql.append("sum(nvl(S.PROVINCE_FAMILY_SUM,0)) PROVINCE_FAMILY_SUM,");
	       sql.append("sum(nvl(S.CITY_FAMILY_SUM,0)) CITY_FAMILY_SUM,");
	       sql.append("sum(nvl(S.COUNTY_FAMILY_SUM,0)) COUNTY_FAMILY_SUM,");
	       sql.append("sum(nvl(S.TOWN_FAMILY_SUM,0)) TOWN_FAMILY_SUM,");
	      
	       sql.append("sum(nvl(S.RELEASE_PEOPLE_SUM,0)) RELEASE_PEOPLE_SUM,");
	       sql.append("sum(nvl(S.CENTRAL_PEOPLE_SUM,0)) CENTRAL_PEOPLE_SUM,");
	       sql.append("sum(nvl(S.PROVINCE_PEOPLE_SUM,0)) PROVINCE_PEOPLE_SUM,");
	       sql.append("sum(nvl(S.CITY_PEOPLE_SUM,0)) CITY_PEOPLE_SUM,");
	       sql.append("sum(nvl(S.COUNTY_PEOPLE_SUM,0)) COUNTY_PEOPLE_SUM,");
	       sql.append("sum(nvl(S.TOWN_PEOPLE_SUM,0)) TOWN_PEOPLE_SUM,");
	      
	       sql.append("sum(nvl(S.ASSISTANCE_MON_SUM,0))+sum(nvl(S.ASSISTANCE_CLASS_MON_SUM,0)) RELEASE_MON_SUM,");
	       sql.append("sum(nvl(S.CENTRAL_MATCHING_MON,0)) CENTRAL_MATCHING_MON,");
	       sql.append("sum(nvl(S.PROVINCE_MATCHING_MON,0)) PROVINCE_MATCHING_MON,");
	       sql.append("sum(nvl(S.CITY_MATCHING_MON,0)) CITY_MATCHING_MON,");
	       sql.append("sum(nvl(S.COUNTY_MATCHING_MON,0)) COUNTY_MATCHING_MON,");
	       sql.append("sum(nvl(S.TOWN_MATCHING_MON,0)) TOWN_MATCHING_MON,");
	       
	       sql.append("sum(nvl(S.ASSISTANCE_MON_SUM,0)) ASSISTANCE_MON_SUM,");
	       sql.append("sum(nvl(S.CENTRAL_ASSISTANCE_MON,0)) CENTRAL_ASSISTANCE_MON,");
	       sql.append("sum(nvl(S.PROVINCE_ASSISTANCE_MON,0)) PROVINCE_ASSISTANCE_MON,");
	       sql.append("sum(nvl(S.CITY_ASSISTANCE_MON,0)) CITY_ASSISTANCE_MON,");
	       sql.append("sum(nvl(S.COUNTY_ASSISTANCE_MON,0)) COUNTY_ASSISTANCE_MON,");
	       sql.append("sum(nvl(S.TOWN_ASSISTANCE_MON,0)) TOWN_ASSISTANCE_MON,");
	      
	       sql.append("sum(nvl(S.ASSISTANCE_CLASS_MON_SUM,0)) ASSISTANCE_CLASS_MON_SUM,");
	       sql.append("sum(nvl(S.CENTRAL_CLASS_MON,0)) CENTRAL_CLASS_MON,");
	       sql.append("sum(nvl(S.PROVINCE_CLASS_MON,0)) PROVINCE_CLASS_MON,");
	       sql.append("sum(nvl(S.CITY_CLASS_MON,0)) CITY_CLASS_MON,");
	       sql.append("sum(nvl(S.COUNTY_CLASS_MON,0)) COUNTY_CLASS_MON,");
	       sql.append("sum(nvl(S.TOWN_CLASS_MON,0)) TOWN_CLASS_MON ");
	       sql.append("from sam_release_stat s where 1=1 ");
	       if (StringUtils.isNotEmpty(beginDate)) {
			sql.append(" and s.RELEASE_DATE =? ");
			argsList.add(beginDate);
			typeList.add(Types.VARCHAR);
	       }
//	       if (StringUtils.isNotEmpty(endDate)) {
//	   		sql.append(" and s.RELEASE_DATE <=? ");
//			argsList.add(endDate);
//			typeList.add(Types.VARCHAR);
//	       
//	       }
	       if (StringUtils.isNotEmpty(isSpecial)) {
	      		sql.append(" and S.IS_SPECIAL =? ");
	   		argsList.add(isSpecial);
	   		typeList.add(Types.VARCHAR);
	          
	        }
	       if(StringUtils.isNotEmpty(assistanceType)){
			   	sql.append(" AND S.ASSISTANCE_TYPE IN (");
				String[] ary = assistanceType.split(",");
				for (int i = 0; i < ary.length; i++) {
					sql.append(" ? ");
					if(i!=ary.length-1){
						sql.append(" , ");
					}
					typeList.add(Types.VARCHAR);
					argsList.add(ary[i]);
				}
				sql.append(" ) ");
		   }
	       if (StringUtils.isNotEmpty(releaseArea)) {
	      		sql.append(" and s.RELEASE_AREA like ? ");
	          	argsList.add(getAreaCodeLikePrefix(releaseArea)+"%");
	      		typeList.add(Types.VARCHAR);
	          
	          }
	       sql.append("group by rpad(substr(RELEASE_AREA, 1, "+getSubstrIndex(releaseArea)+"), 12, '0') ,GET_CITYNAME(rpad(substr(RELEASE_AREA, 1, "+getSubstrIndex(releaseArea)+"), 12, '0') )");
	       sql.append("  ) al on  al.RELEASE_AREA=d.id ");
	       sql.append("  where d.id = rpad(substr(d.id, 1, "+getSubstrIndex(releaseArea)+"), 12, '0')");
	       if (StringUtils.isNotEmpty(releaseArea)) {
	    	   if(releaseArea.endsWith("000")){
			    	sql.append(" and d.ups=?  " );
			   } else {
			    	sql.append(" and d.id=?  " );
			   }
	    		typeList.add(Types.VARCHAR);
	      		argsList.add(releaseArea);
	       }
//	       if (StringUtils.isNotEmpty(releaseArea)) {
//	    	   sql.append("  and d.ups=? ");
//	      		typeList.add(Types.VARCHAR);
//	      		argsList.add(releaseArea);
//	       }
	       sql.append(" order by d.id ");
	       DataSet ds=new DataSet();
	       if (typeList.size() != 0 && argsList.size() != 0) {
				int[] types = new int[typeList.size()];
				for (int i = 0; i < typeList.size(); i++) {
					types[i] = typeList.get(i);
				}
				Object[] args = argsList.toArray(new Object[argsList.size()]);
				ds = this.executeDataset(sql.toString(), types, args,true);
			} else {
				ds = this.executeDataset(sql.toString(), true);
			}

			return ds;
	}

	/**
	* @Title: querySpecialReleaseStat
	* @Description: TODO(专项补贴统计)
	* @param pset
	* @return DataSet  
	* @throws
	* @author luguosui
	 */
	public DataSet querySpecialReleaseStat(ParameterSet pset) {
		String releaseId=(String)pset.getParameter("releaseId");
		String isSpecial=(String)pset.getParameter("isSpecial");
		String releaseArea=(String)pset.getParameter("releaseArea");
		String releaseDate=(String)pset.getParameter("releaseDate");
		String organArea=(String)pset.getParameter("organArea");
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("procedureName", "SAM_RELEASE_STAT_QUERY");
		map.put("parameterNum", 5);
		map.put("parameterName_1", "releaseId");
		map.put("parameterName_2", "isSpecial");
		map.put("parameterName_3", "releaseArea");
		map.put("parameterName_4", "releaseDate");
		map.put("parameterName_5", "organArea");
		map.put("NumberOfResultSet",1);
		Proc procduce = new ProceduresUtil().init(getDataSource(),map);
		map.put("parameterValue_1", releaseId);
		map.put("parameterValue_2", isSpecial);
		map.put("parameterValue_3", releaseArea);
		map.put("parameterValue_4", releaseDate);
		map.put("parameterValue_5", organArea);
		DataSet set = new DataSet();
		List results = null;
		Object object = null;
		object = procduce.call(map).get("results");
		if (object instanceof ArrayList) {
			results = (List) object;
			for (Object o : results) {
				set.add((Record) o);
			}
		}
		set = ProceduresUtil.fixDataSet(set);
		return set;
	}

	/**
	* @Title: queryAssistancPeoNum
	* @Description: TODO(辅助决策低保五保人数查询)
	* @param pset
	* @return DataSet  
	* @throws
	* @author luguosui
	 */
	public DataSet queryAssistancPeoNum(ParameterSet pset) {
	String assistanceType=(String)pset.getParameter("assistanceType");
	String releaseArea=(String)pset.getParameter("releaseArea");
	String releaseDate=(String)pset.getParameter("releaseDate");
	Map<String,Object> map = new HashMap<String, Object>();
	String releaseAreaCode="";
	if(releaseArea.indexOf("000")>-1){
		releaseAreaCode=releaseArea.substring(0,releaseArea.indexOf("000"))+"%";
	}else {
		releaseAreaCode=releaseArea+"%";
	}
	map.put("procedureName", "SAM_PEO_NUM");
	map.put("parameterNum", 4);
	map.put("parameterName_1", "assistanceType");
	map.put("parameterName_2", "releaseArea");
	map.put("parameterName_3", "releaseDate");
	map.put("parameterName_4", "releaseAreaCode");
	map.put("NumberOfResultSet",1);
	Proc procduce = new ProceduresUtil().init(getDataSource(),map);
	map.put("parameterValue_1", assistanceType);
	map.put("parameterValue_2", releaseArea);
	map.put("parameterValue_3", releaseDate);
	map.put("parameterValue_4", releaseAreaCode);
	DataSet set = new DataSet();
	List results = null;
	Object object = null;
	object = procduce.call(map).get("results");
	if (object instanceof ArrayList) {
		results = (List) object;
		for (Object o : results) {
			set.add((Record) o);
		}
	}
	set = ProceduresUtil.fixDataSet(set);
	return set;
	}

	/**
	* @Title: queryPeoAverageStat
	* @Description: TODO(人均补差统计方法)
	* @param pset
	* @return DataSet  
	* @throws to_char(round(sum(INSURANCE_EXPENSE),2),'FM99,999,999,990.00')
	* @author luguosui
	 */
	public DataSet queryPeoAverageStat(ParameterSet pset) {
		StringBuffer sql=new StringBuffer(); 
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
	    String beginDate=(String)pset.getParameter("beginDate");
	    String endDate=(String)pset.getParameter("endDate");
	    String releaseDate=(String)pset.getParameter("releaseDate");
	    String releaseArea=(String)pset.getParameter("releaseArea");
	    String assistanceType=(String)pset.getParameter("assistanceType"); 
	    sql.append(" select d.id, d.Name, al.* ");
	    sql.append("   from dic_city d ");
	    sql.append("   left join ");
	    sql.append(" (select rpad(substr(S.RELEASE_AREA, 1, "+getSubstrIndex(releaseArea)+"), 12, '0') RELEASE_AREA, sum(nvl(s.RELEASE_PEOPLE_SUM, 0)) AS RELEASE_PEOPLE_SUM, ");
	    sql.append("  sum(case when s.IS_SPECIAL = '0' then nvl(s.ASSISTANCE_MON_SUM, 0) else 0 end) AS ASSISTANCE_MON_SUM, ");
	    sql.append("  sum(case when s.IS_SPECIAL = '0' then nvl(s.ASSISTANCE_CLASS_MON_SUM, 0) else 0 end) AS ASSISTANCE_CLASS_MON_SUM, ");
	    sql.append("  sum(case when s.IS_SPECIAL = '1' and s.RELEASE_ITEM = '8a898bd337f37d4f0137f40e27320081' then nvl(s.RELEASE_MON_SUM, 0) else 0 end) AS Water_Release_sum,");
	    sql.append("  sum(nvl(RELEASE_MON_SUM, 0)) AS RELEASE_MON_SUM,sum(case when s.IS_SPECIAL = '0' then nvl(RELEASE_FAMILY_SUM, 0) else 0 end) AS RELEASE_FAMILY_SUM,");
	    sql.append("  (round(sum(nvl(RELEASE_MON_SUM, 0)) / (case when sum(nvl(s.RELEASE_PEOPLE_SUM, 0))=0 then 1 else sum(nvl(s.RELEASE_PEOPLE_SUM, 0)) end))) PEOple_AVERAGE");
	    sql.append("  from sam_release_stat s");
	    sql.append(" where 1=1 ");
	    if(StringUtils.isNotEmpty(assistanceType)){
		   	sql.append(" AND S.ASSISTANCE_TYPE IN (");
			String[] ary = assistanceType.split(",");
			for (int i = 0; i < ary.length; i++) {
				sql.append(" ? ");
				if(i!=ary.length-1){
					sql.append(" , ");
				}
				typeList.add(Types.VARCHAR);
				argsList.add(ary[i]);
			}
			sql.append(" ) ");
	   }
	    if (StringUtils.isNotEmpty(beginDate)) {
		    sql.append(" and s.RELEASE_DATE = ?  "); 
	   		argsList.add(beginDate);
	   		typeList.add(Types.VARCHAR);
	    }
//	    if (StringUtils.isNotEmpty(endDate)) {
//		    sql.append(" and s.RELEASE_DATE <= ?  "); 
//	   		argsList.add(endDate);
//	   		typeList.add(Types.VARCHAR);
//	    }
	    if (StringUtils.isNotEmpty(releaseArea)) {
		    sql.append(" and s.RELEASE_AREA like  ?  "); 
		    if(releaseArea.indexOf("000")>-1){
		   		argsList.add(getAreaCodeLikePrefix(releaseArea)+"%");
		    }else {
		   		argsList.add(releaseArea+"%");
			}
	   		typeList.add(Types.VARCHAR);
	    }
	    sql.append(" group by rpad(substr(S.RELEASE_AREA, 1, "+getSubstrIndex(releaseArea)+"), 12, '0') ");
	    sql.append("  ) al on al.RELEASE_AREA = d.id ");
	    sql.append(" where d.id = rpad(substr(d.id, 1, "+getSubstrIndex(releaseArea)+"), 12, '0')  " );
	    if(releaseArea.endsWith("000")){
	    	sql.append(" and d.ups=?  " );
	    } else {
	    	sql.append(" and d.id=?  " );
	    }
   		argsList.add(releaseArea);
   		typeList.add(Types.VARCHAR);
	    sql.append(" order by d.id ");
	    DataSet ds=new DataSet();
	       if (typeList.size() != 0 && argsList.size() != 0) {
				int[] types = new int[typeList.size()];
				for (int i = 0; i < typeList.size(); i++) {
					types[i] = typeList.get(i);
				}
				Object[] args = argsList.toArray(new Object[argsList.size()]);
				ds = this.executeDataset(sql.toString(), types, args,true);
			} else {
				ds = this.executeDataset(sql.toString(), true);
			}

			return ds;
	}
	private String getAreaCodeLikePrefix(String releaseArea) {
        if(releaseArea.endsWith("0000000000")){//省370000000000
			return releaseArea.substring(0,2);
		} else if (releaseArea.endsWith("00000000")){//市370100000000
			return releaseArea.substring(0,4);
		} else if (releaseArea.endsWith("000000")){//县370104000000
			return releaseArea.substring(0,6);
		} else if (releaseArea.endsWith("000")){//乡370104003000
			return releaseArea.substring(0,9);
		}
        return releaseArea;
	}
	private int getAreaCodeIndex(String areaCode) {
		int index=12;
        if(areaCode.endsWith("0000000000")){//省370000000000
			index=4;
		} else if (areaCode.endsWith("00000000")){//市370100000000
			index=6;
		} else if (areaCode.endsWith("000000")){//县370104000000
			index=9;
		} else if (areaCode.endsWith("000")){//乡370104003000
			index=12;
		}
        return index;
	}
}
