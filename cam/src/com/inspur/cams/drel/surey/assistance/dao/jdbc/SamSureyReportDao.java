package com.inspur.cams.drel.surey.assistance.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.persistent.util.domain.BaseJdbcDao;

import com.inspur.sdmz.comm.util.BspUtil;

@SuppressWarnings("unchecked")
public class SamSureyReportDao extends BaseJdbcDao {

	/**
	 * 民政局用户统计报表
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet statsReport(ParameterSet pset) {
		String organCode=BspUtil.getCorpOrgan().getOrganCode(); 
		// 数据权限过滤--上级能查看下级，下级不能查看上级
		String createOrgan = "";
		if (organCode.substring(4, 12).equals("00000000")) {
			createOrgan = organCode.substring(0, 4);
		} else if (organCode.substring(6, 12).equals("000000")
				|| organCode.substring(6, 12) == "000000") {
			createOrgan = organCode.substring(0, 6);
		} else {
			createOrgan = organCode;
		}
		String SURVEY_ORGAN_TYPE = (String) pset.getParameter("SURVEY_ORGAN_TYPE");
		String SURVEY_ORGAN_AREA = (String) pset.getParameter("SURVEY_ORGAN_AREA");

		String applyDateQ = (String) pset.getParameter("applyDateQ");//申请日期
		String applyDateZ = (String) pset.getParameter("applyDateZ");//申请日期		
		String assistanceType = (String) pset.getParameter("assistanceType");//核对项目
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argList = new ArrayList<Object>();
		String CITY_DISTRICT = (String) pset.getParameter("CITY_DISTRICT");
		//1、获取受理单位
		StringBuffer sql = new StringBuffer();
		if (CITY_DISTRICT != null && "beCity".equals(CITY_DISTRICT)) {
			sql.append("SELECT s.SURVEY_ORGAN_TYPE,s.SURVEY_ORGAN_AREA,s.SURVEY_ORGAN_NAME from SAM_SUREY_WF w ,SAM_SUREY s ,SAM_ESUREY_PEOPLE p where w.SURVEY_ID=s.SURVEY_ID and w.SURVEY_ID=p.SURVEY_ID ");
		} else if (CITY_DISTRICT != null && "beDistrict".equals(CITY_DISTRICT)) {
			sql.append("SELECT S.APPLY_ORGAN_TYPE,s.APPLY_ORGAN_AREA,S.APPLY_ORGAN_NAME FROM SAM_SUREY_WF w ,SAM_SUREY s ,SAM_ESUREY_PEOPLE p where w.SURVEY_ID=s.SURVEY_ID and w.SURVEY_ID=p.SURVEY_ID ");
		}
		sql.append(" and w.SURVEY_TYPE in (02,03) ");
		sql.append(" and w.PARENT_FLOW_ID is null ");
		sql.append(" and w.IS_FINISH is not null ");
		sql.append(" and s.SURVEY_ORGAN_TYPE=? ");//审核单位
		typeList.add(Types.VARCHAR);
		argList.add(SURVEY_ORGAN_TYPE);
		sql.append(" and S.SURVEY_ORGAN_AREA LIKE ? ");
		typeList.add(Types.VARCHAR);
		argList.add(createOrgan+'%');
		
		if (applyDateQ != null && !"".equals(applyDateQ)) {
			sql.append(" AND s.APPLY_DATE>=? ");
			typeList.add(Types.VARCHAR);
			argList.add(applyDateQ);
		}
		if (applyDateZ != null && !"".equals(applyDateZ)) {
			sql.append(" AND s.APPLY_DATE<=? ");
			typeList.add(Types.VARCHAR);
			argList.add(applyDateZ);
		}		
		if (assistanceType != null && !"".equals(assistanceType)) {
			sql.append(" AND s.ASSISTANCE_TYPE=? ");
			typeList.add(Types.VARCHAR);
			argList.add(assistanceType);
		}			
		
		if (CITY_DISTRICT != null && "beCity".equals(CITY_DISTRICT)) {
			sql.append(" GROUP BY s.SURVEY_ORGAN_TYPE,s.SURVEY_ORGAN_AREA,s.SURVEY_ORGAN_NAME");
		} else if (CITY_DISTRICT != null && "beDistrict".equals(CITY_DISTRICT)) {
			sql.append(" GROUP BY S.APPLY_ORGAN_TYPE,s.APPLY_ORGAN_AREA,S.APPLY_ORGAN_NAME");
		}
		List list=new ArrayList();
		if(typeList.size()==argList.size() && typeList.size()!=0){
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = argList.toArray(new Object[argList.size()]);
			list = this.executeQuery(sql.toString(), types, args);
		}else{
			list= this.executeQuery(sql.toString());
		}
		if(list == null || list.size()<1) return new DataSet();
		DataSet reDs = new DataSet();
		Iterator it = list.listIterator();
		while(it.hasNext()) {
			Map map = (Map)it.next();
			String dwType = "";
			String dwId = "";
			String dwName = "";
			if (CITY_DISTRICT != null && "beCity".equals(CITY_DISTRICT)) {
				dwType = (String) map.get("SURVEY_ORGAN_TYPE");
				dwId = (String) map.get("SURVEY_ORGAN_AREA");	
				dwName = (String) map.get("SURVEY_ORGAN_NAME");	
			} else if (CITY_DISTRICT != null && "beDistrict".equals(CITY_DISTRICT)) {
				dwType = (String) map.get("APPLY_ORGAN_TYPE");
				dwId = (String) map.get("APPLY_ORGAN_AREA");	
				dwName = (String) map.get("APPLY_ORGAN_NAME");				
			}
			
			if(null!=dwName && !"".equals(dwName)) {
				typeList = new ArrayList<Integer>();
				argList = new ArrayList<Object>();
				sql = new StringBuffer();
				sql.append("SELECT TO_CHAR(COUNT(*)) VALUE, S.ASSISTANCE_TYPE,w.IS_FINISH from SAM_SUREY_WF w ,SAM_SUREY s ,SAM_ESUREY_PEOPLE p where w.SURVEY_ID=s.SURVEY_ID and w.SURVEY_ID=p.SURVEY_ID ");
				sql.append(" and w.SURVEY_TYPE in (02,03) ");
				sql.append(" and w.PARENT_FLOW_ID is null ");
				sql.append(" and w.IS_FINISH is not null ");
				if (CITY_DISTRICT != null && "beCity".equals(CITY_DISTRICT)) {
					sql.append(" and s.SURVEY_ORGAN_TYPE=? ");// 审核单位
					typeList.add(Types.VARCHAR);
					argList.add(dwType);
					sql.append(" and S.SURVEY_ORGAN_AREA=? ");
					typeList.add(Types.VARCHAR);
					argList.add(dwId);
					sql.append(" and S.APPLY_ORGAN_AREA=? ");
					typeList.add(Types.VARCHAR);
					argList.add(dwId);
				}else if (CITY_DISTRICT != null && "beDistrict".equals(CITY_DISTRICT)) {
					sql.append(" and S.SURVEY_ORGAN_TYPE = ? ");//审核单位
					typeList.add(Types.VARCHAR);
					argList.add(SURVEY_ORGAN_TYPE);
					sql.append(" AND S.SURVEY_ORGAN_AREA=? ");
					typeList.add(Types.VARCHAR);
					argList.add(SURVEY_ORGAN_AREA);
					sql.append(" and s.APPLY_ORGAN_TYPE=? ");
					typeList.add(Types.VARCHAR);
					argList.add(dwType);
					sql.append(" and S.APPLY_ORGAN_AREA=? ");
					typeList.add(Types.VARCHAR);
					argList.add(dwId);
				}

				if (applyDateQ != null && !"".equals(applyDateQ)) {
					sql.append(" AND s.APPLY_DATE>=? ");
					typeList.add(Types.VARCHAR);
					argList.add(applyDateQ);
				}
				if (applyDateZ != null && !"".equals(applyDateZ)) {
					sql.append(" AND s.APPLY_DATE<=? ");
					typeList.add(Types.VARCHAR);
					argList.add(applyDateZ);
				}	
				if (assistanceType != null && !"".equals(assistanceType)) {
					sql.append(" AND s.ASSISTANCE_TYPE=? ");
					typeList.add(Types.VARCHAR);
					argList.add(assistanceType);
				}
				
				sql.append(" GROUP BY S.ASSISTANCE_TYPE,w.IS_FINISH");
				List listO=new ArrayList();
				if(typeList.size()==argList.size() && typeList.size()!=0){
					int[] types = new int[typeList.size()];
					for (int i = 0; i < typeList.size(); i++) {
						types[i] = typeList.get(i);
					}
					Object[] args = argList.toArray(new Object[argList.size()]);
					listO = this.executeQuery(sql.toString(), types, args);
				}else{
					listO= this.executeQuery(sql.toString());
				}
				reDs.addRecord(getBean(listO,dwType, dwId,dwName));
			}
		}
		return reDs;
	}
	
	/**
	 * 外部单位用户统计报表
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet extStatsReport(ParameterSet pset) {
		String APPLY_ORGAN_TYPE = (String) pset.getParameter("APPLY_ORGAN_TYPE");
		String APPLY_ORGAN_AREA = (String) pset.getParameter("APPLY_ORGAN_AREA");
		String applyDateQ = (String) pset.getParameter("applyDateQ");//申请日期
		String applyDateZ = (String) pset.getParameter("applyDateZ");//申请日期	
		String assistanceType = (String) pset.getParameter("assistanceType");//核对项目
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		sql.append("select s.SURVEY_ORGAN_TYPE,s.SURVEY_ORGAN_AREA,s.SURVEY_ORGAN_NAME from SAM_SUREY_WF w ,SAM_SUREY s ,SAM_ESUREY_PEOPLE p where w.SURVEY_ID=s.SURVEY_ID and w.SURVEY_ID=p.SURVEY_ID ");
		sql.append(" and w.SURVEY_TYPE in (02,03) ");
		sql.append(" and w.PARENT_FLOW_ID is null ");
		sql.append(" and w.IS_FINISH is not null ");
		sql.append(" and s.APPLY_ORGAN_TYPE=? ");//申请单位
		typeList.add(Types.VARCHAR);
		argList.add(APPLY_ORGAN_TYPE);
		sql.append(" and s.APPLY_ORGAN_AREA=? ");
		typeList.add(Types.VARCHAR);
		argList.add(APPLY_ORGAN_AREA);
		sql.append(" and S.SURVEY_ORGAN_TYPE is not null ");//审核单位
		if (applyDateQ != null && !"".equals(applyDateQ)) {
			sql.append(" AND s.APPLY_DATE>=? ");
			typeList.add(Types.VARCHAR);
			argList.add(applyDateQ);
		}
		if (applyDateZ != null && !"".equals(applyDateZ)) {
			sql.append(" AND s.APPLY_DATE<=? ");
			typeList.add(Types.VARCHAR);
			argList.add(applyDateZ);
		}		
		if (assistanceType != null && !"".equals(assistanceType)) {
			sql.append(" AND s.ASSISTANCE_TYPE=? ");
			typeList.add(Types.VARCHAR);
			argList.add(assistanceType);
		}		
		sql.append(" GROUP BY s.SURVEY_ORGAN_TYPE,s.SURVEY_ORGAN_AREA,s.SURVEY_ORGAN_NAME ");
		
		List list=new ArrayList();
		if(typeList.size()==argList.size() && typeList.size()!=0){
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = argList.toArray(new Object[argList.size()]);
			list = this.executeQuery(sql.toString(), types, args);
		}else{
			list= this.executeQuery(sql.toString());
		}
		DataSet reDs = new DataSet();
		if(list == null || list.size()<1) {
			return new DataSet();
		}
		Iterator it = list.listIterator();
		while(it.hasNext()) {
			Map map = (Map)it.next();
			String dwType=(String)map.get("SURVEY_ORGAN_TYPE");
			String dwId = (String)map.get("SURVEY_ORGAN_AREA");
			String dwName = (String)map.get("SURVEY_ORGAN_NAME");
			typeList = new ArrayList<Integer>();
			argList = new ArrayList<Object>();
			sql = new StringBuffer();
			sql.append("SELECT TO_CHAR(COUNT(*)) VALUE, S.ASSISTANCE_TYPE,w.IS_FINISH from SAM_SUREY_WF w ,SAM_SUREY s ,SAM_ESUREY_PEOPLE p where w.SURVEY_ID=s.SURVEY_ID and w.SURVEY_ID=p.SURVEY_ID ");
			sql.append(" and w.SURVEY_TYPE in (02,03) ");
			sql.append(" and w.PARENT_FLOW_ID is null ");
			sql.append(" and w.IS_FINISH is not null ");
			sql.append(" and s.APPLY_ORGAN_TYPE=? ");//申请单位
			typeList.add(Types.VARCHAR);
			argList.add(APPLY_ORGAN_TYPE);
			sql.append(" and s.APPLY_ORGAN_AREA=? ");
			typeList.add(Types.VARCHAR);
			argList.add(APPLY_ORGAN_AREA);
			sql.append(" and S.SURVEY_ORGAN_TYPE = ? ");//审核单位
			typeList.add(Types.VARCHAR);
			argList.add(dwType);
			sql.append(" AND S.SURVEY_ORGAN_AREA=? ");
			typeList.add(Types.VARCHAR);
			argList.add(dwId);
			if (applyDateQ != null && !"".equals(applyDateQ)) {
				sql.append(" AND s.APPLY_DATE>=? ");
				typeList.add(Types.VARCHAR);
				argList.add(applyDateQ);
			}
			if (applyDateZ != null && !"".equals(applyDateZ)) {
				sql.append(" AND s.APPLY_DATE<=? ");
				typeList.add(Types.VARCHAR);
				argList.add(applyDateZ);
			}	
			if (assistanceType != null && !"".equals(assistanceType)) {
				sql.append(" AND s.ASSISTANCE_TYPE=? ");
				typeList.add(Types.VARCHAR);
				argList.add(assistanceType);
			}
			sql.append(" GROUP BY S.ASSISTANCE_TYPE,w.IS_FINISH");
			
			List listO=new ArrayList();
			if(typeList.size()==argList.size() && typeList.size()!=0){
				int[] types = new int[typeList.size()];
				for (int i = 0; i < typeList.size(); i++) {
					types[i] = typeList.get(i);
				}
				Object[] args = argList.toArray(new Object[argList.size()]);
				listO = this.executeQuery(sql.toString(), types, args);
			}else{
				listO= this.executeQuery(sql.toString());
			}
			reDs.addRecord(getBean(listO,dwType, dwId,dwName));
		}
		return reDs;
	}
	
	private Record getBean(List list,String dwType,	String dwId, String dwName) {
		if(list==null || list.size() <1) {
			return new Record();
		}
		Record record = new Record();
		record.set("type", dwType);
		record.set("id", dwId);
		record.set("name", dwName);
		int row1 = 0;  
		int row2 = 0;  
		int row3 = 0;  
		int row4 = 0;  
		int row5 = 0; 
		int row6 = 0;  
		int row7 = 0; 
		int row8 = 0;  
		int row9 = 0; 
		int row10 = 0;  
		int row11 = 0;  
		int row12 = 0; 
		
		for (int i = 0; i < list.size(); i++) {
			Map map = (Map) list.get(i);
			String applyType = (String) map.get("ASSISTANCE_TYPE");
			String isFinish = (String) map.get("IS_FINISH");
			String value = ((String) map.get("VALUE"));
			if ("01".equals(applyType)) {
				if ("1".equals(isFinish)) {
					// 已办结
					row4 += Integer.parseInt(value);
					row5 += Integer.parseInt(value);
					
					row1 += Integer.parseInt(value);
					row2 += Integer.parseInt(value);
				} else if ("0".equals(isFinish)) {
					//未办结
					row4 += Integer.parseInt(value);
					row6 += Integer.parseInt(value);
					
					row1 += Integer.parseInt(value);
					row3 += Integer.parseInt(value);
				}
			} else if ("02".equals(applyType)) {
				if ("1".equals(isFinish)) {
					// 已办结
					row7 += Integer.parseInt(value);
					row8 += Integer.parseInt(value);
					
					row1 += Integer.parseInt(value);
					row2 += Integer.parseInt(value);
				} else if ("0".equals(isFinish)) {
					//未办结
					row7 += Integer.parseInt(value);
					row9 += Integer.parseInt(value);
					
					row1 += Integer.parseInt(value);
					row3 += Integer.parseInt(value);					
				}
			} else if ("03".equals(applyType)) {
				if ("1".equals(isFinish)) {
					// 已办结
					row10 += Integer.parseInt(value);
					row11 += Integer.parseInt(value);
					
					row1 += Integer.parseInt(value);
					row2 += Integer.parseInt(value);
				} else if ("0".equals(isFinish)) {
					//未办结
					row10 += Integer.parseInt(value);
					row12 += Integer.parseInt(value);
					
					row1 += Integer.parseInt(value);
					row3 += Integer.parseInt(value);					
				}
			}
		}
		record.set("Row1", row1);
		record.set("Row2", row2);
		record.set("Row3", row3);
		record.set("Row4", row4);
		record.set("Row5", row5);
		record.set("Row6", row6);
		record.set("Row7", row7);
		record.set("Row8", row8);
		record.set("Row9", row9);
		record.set("Row10", row10);
		record.set("Row11", row11);
		record.set("Row12", row12);		
		return record;
	}
	@Override
	protected void initDao() {
		// TODO Auto-generated method stub
		
	}
}
