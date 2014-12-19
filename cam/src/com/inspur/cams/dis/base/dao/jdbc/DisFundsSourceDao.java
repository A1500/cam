package com.inspur.cams.dis.base.dao.jdbc;

import java.math.BigDecimal;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import net.sf.jasperreports.engine.util.BigDecimalUtils;

import org.apache.commons.lang.ObjectUtils;
import org.apache.commons.lang.StringUtils;
import org.loushang.bsp.security.context.GetBspInfo;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.ProceduresUtil;
import com.inspur.cams.comm.util.ProceduresUtil.Proc;
import com.inspur.cams.dis.base.dao.IDisFundsSourceDao;
import com.inspur.cams.dis.base.data.DisFundsSource;
import com.inspur.cams.dis.base.data.DisFundsSourceBatch;

/**
 * 资金拨付表dao
 * @author 
 * @date 2013-01-04
 */
public class DisFundsSourceDao extends EntityDao<DisFundsSource> implements IDisFundsSourceDao {
	
	@Override
	public Class<DisFundsSource> getEntityClass() {
		return DisFundsSource.class;
	}
	
	/**
	 * 修改基本
	 */
	public void updateBase(DisFundsSourceBatch disFundsSourceBatch) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		sql.append("UPDATE DIS_FUNDS_SOURCE SET DIS_YEAR=?, UP_ALLOCATION_NUM=?, UP_ALLOCATION_TYPE=?,UP_ALLOCATION_PURPOSE=?,UPDATE_PEOPLE_NAME=?,UPDATE_TIME=? WHERE BATCH_ID=?");
		typeList.add(Types.VARCHAR);
		objList.add(disFundsSourceBatch.getDisYear());
		
		typeList.add(Types.VARCHAR);
		objList.add(disFundsSourceBatch.getUpAllocationNum());
		typeList.add(Types.VARCHAR);
		objList.add(disFundsSourceBatch.getUpAllocationType());
		typeList.add(Types.VARCHAR);
		objList.add(disFundsSourceBatch.getUpAllocationPurpose());
		
		typeList.add(Types.VARCHAR);
		objList.add(disFundsSourceBatch.getUpdatePeopleName());
		typeList.add(Types.VARCHAR);
		objList.add(disFundsSourceBatch.getUpdateTime());
		typeList.add(Types.VARCHAR);
		objList.add(disFundsSourceBatch.getBatchId());
		
		if(typeList.size()>0&&objList.size()>0){
			int[] types = new int[typeList.size()];
			for (int i = 0; i < types.length; i++) {
				types[i]=typeList.get(i);
			}
			Object[] objs = objList.toArray(new Object[objList.size()]);
			this.executeUpdate(sql.toString(), types, objs);
		}
	}
	
	/**
	 * @Description: 查询资金
	 * @author xuexzh
	 */
	public DataSet queryFunds(ParameterSet pset) {
		String organType = BspUtil.getOrganType();
		String sourceId = (String) pset.get("sourceId");
		String fundsType = (String) pset.get("fundsType");
		String sourceType = (String) pset.get("sourceType");
		String receiveOrganCode = (String) pset.get("receiveOrganCode");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		DataSet ds = new DataSet();
		
		if("11".equals(organType)) {
			//获取省级所需数据-省
			sql.append("SELECT * FROM (");
			sql.append(" SELECT F.*,F.AMOUNT_BALANCE AMOUNT_EXT_TOTAL,0.0 AMOUNT_EXT_REAL,F.METERIAL_BALANCE METERIAL_EXT_TOTAL,0.0 METERIAL_EXT_REAL");
			sql.append("   FROM DIS_FUNDS_SOURCE F WHERE F.RECEIVE_ORGAN_CODE=? AND F.IN_REF=?  ");
			sql.append("   AND F.SOURCE_ID NOT IN (SELECT S.OLD_SOURCE_ID FROM DIS_FUNDS_SOURCE S WHERE S.END_SOURCE_ID=? AND S.IN_REF=?)");
			
			typeList.add(Types.VARCHAR);
			objList.add(receiveOrganCode);
			typeList.add(Types.VARCHAR);
			objList.add("0");
			typeList.add(Types.VARCHAR);
			objList.add(sourceId);
			typeList.add(Types.VARCHAR);
			objList.add("1");
			if(sourceType.indexOf(",") != -1) {
				sql.append(" AND F.SOURCE_TYPE IN (");
				String[] st = sourceType.split(",");
				for(int j=0; j<st.length; j++) {
					sql.append("?");
					typeList.add(Types.VARCHAR);
					objList.add(st[j]);
					if(j+1!=st.length) {
						sql.append(",");
					}
				}
				sql.append(")");
			}else {
				sql.append(" AND F.SOURCE_TYPE=? ");
				typeList.add(Types.VARCHAR);
				objList.add(sourceType);
			}
			sql.append(" UNION ");
			sql.append(" SELECT AA.*,AA.AMOUNT_BALANCE+FS.AMOUNT AMOUNT_EXT_TOTAL,FS.AMOUNT AMOUNT_EXT_REAL,AA.METERIAL_BALANCE+FS.METERIAL METERIAL_EXT_TOTAL,FS.METERIAL METERIAL_EXT_REAL FROM (");       
			sql.append("  SELECT F.* FROM DIS_FUNDS_SOURCE F WHERE F.RECEIVE_ORGAN_CODE=? AND F.IN_REF=?  ");
			sql.append("    AND F.SOURCE_ID IN (SELECT S.OLD_SOURCE_ID FROM DIS_FUNDS_SOURCE S WHERE S.END_SOURCE_ID=? AND S.IN_REF=?)");
			typeList.add(Types.VARCHAR);
			objList.add(receiveOrganCode);
			typeList.add(Types.VARCHAR);
			objList.add("0");
			typeList.add(Types.VARCHAR);
			objList.add(sourceId);
			typeList.add(Types.VARCHAR);
			objList.add("1");
			if(sourceType.indexOf(",") != -1) {
				sql.append(" AND F.SOURCE_TYPE IN (");
				String[] st = sourceType.split(",");
				for(int j=0; j<st.length; j++) {
					sql.append("?");
					typeList.add(Types.VARCHAR);
					objList.add(st[j]);
					if(j+1!=st.length) {
						sql.append(",");
					}
				}
				sql.append(")");
			}else {
				sql.append(" AND F.SOURCE_TYPE=? ");
				typeList.add(Types.VARCHAR);
				objList.add(sourceType);
			}			
			sql.append("  ) AA LEFT JOIN (SELECT * FROM DIS_FUNDS_SOURCE WHERE END_SOURCE_ID=? AND IN_REF=?) FS ON AA.SOURCE_ID=FS.OLD_SOURCE_ID WHERE FS.END_SOURCE_ID=?"); 
			sql.append(" ) AAA WHERE AAA.AMOUNT_EXT_TOTAL>0 OR AAA.METERIAL_EXT_TOTAL>0 ");
			sql.append(" ORDER BY AAA.AMOUNT_EXT_REAL DESC,AAA.METERIAL_EXT_REAL DESC,AAA.DIS_YEAR DESC,AAA.UP_ALLOCATION_NUM,AAA.FILL_TIME DESC");

			typeList.add(Types.VARCHAR);
			objList.add(sourceId);
			typeList.add(Types.VARCHAR);
			objList.add("1");
			typeList.add(Types.VARCHAR);
			objList.add(sourceId);
		}else if("12".equals(organType)) {
			//获取市级所需数据
			if("0".equals(sourceType)) {
				//查询上级下拨款项-市
				sql.append("SELECT * FROM (");
				sql.append(" SELECT F.*,F.AMOUNT_BALANCE AMOUNT_EXT_TOTAL,0.0 AMOUNT_EXT_REAL,F.METERIAL_BALANCE METERIAL_EXT_TOTAL,0.0 METERIAL_EXT_REAL");
				sql.append(" FROM DIS_FUNDS_SOURCE F WHERE F.OLD_FUNDS_TYPE=? AND F.END_SOURCE_ID IN (SELECT SOURCE_ID FROM DIS_FUNDS_SOURCE");
				sql.append(" WHERE SOURCE_TYPE=? AND RECEIVE_ORGAN_CODE=? AND IN_REF=? AND IN_USE!=?)");
				sql.append(" AND F.SOURCE_ID NOT IN (SELECT OLD_SOURCE_ID FROM DIS_FUNDS_SOURCE WHERE END_SOURCE_ID=? AND IN_REF=?)");
				typeList.add(Types.VARCHAR);
				objList.add(fundsType);
				typeList.add(Types.VARCHAR);
				objList.add(sourceType);
				typeList.add(Types.VARCHAR);
				objList.add(receiveOrganCode);
				typeList.add(Types.VARCHAR);
				objList.add("0");
				
				typeList.add(Types.VARCHAR);
				objList.add("9");
				typeList.add(Types.VARCHAR);
				objList.add(sourceId);
				typeList.add(Types.VARCHAR);
				objList.add("1");
				
				sql.append(" UNION ");
				sql.append(" SELECT AAA.*,AAA.AMOUNT_BALANCE+DFS.AMOUNT AMOUNT_EXT_TOTAL,DFS.AMOUNT AMOUNT_EXT_REAL,AAA.METERIAL_BALANCE+DFS.METERIAL METERIAL_EXT_TOTAL,");
				sql.append(" DFS.METERIAL METERIAL_EXT_REAL FROM ");
				sql.append(" (SELECT FS.* FROM DIS_FUNDS_SOURCE FS WHERE FS.OLD_FUNDS_TYPE=? AND FS.END_SOURCE_ID IN (SELECT SOURCE_ID FROM DIS_FUNDS_SOURCE");
				sql.append("    WHERE SOURCE_TYPE=? AND RECEIVE_ORGAN_CODE=? AND IN_REF=? AND IN_USE!=?)");
				sql.append("    AND FS.SOURCE_ID IN (SELECT OLD_SOURCE_ID FROM DIS_FUNDS_SOURCE WHERE END_SOURCE_ID=? AND IN_REF=?)");
				sql.append(" ) AAA LEFT JOIN (SELECT * FROM DIS_FUNDS_SOURCE WHERE END_SOURCE_ID=? AND IN_REF=?) DFS ON AAA.SOURCE_ID=DFS.OLD_SOURCE_ID ");
				sql.append(" ) AAAA WHERE AAAA.AMOUNT_EXT_TOTAL>0 OR AAAA.METERIAL_EXT_TOTAL>0 ");
				typeList.add(Types.VARCHAR);
				objList.add(fundsType);
				typeList.add(Types.VARCHAR);
				objList.add(sourceType);
				typeList.add(Types.VARCHAR);
				objList.add(receiveOrganCode);
				typeList.add(Types.VARCHAR);
				objList.add("0");
				
				typeList.add(Types.VARCHAR);
				objList.add("9");
				typeList.add(Types.VARCHAR);
				objList.add(sourceId);
				typeList.add(Types.VARCHAR);
				objList.add("1");
				typeList.add(Types.VARCHAR);
				objList.add(sourceId);
				typeList.add(Types.VARCHAR);
				objList.add("1");
				
				sql.append(" ORDER BY AAAA.AMOUNT_EXT_REAL DESC,AAAA.METERIAL_EXT_REAL DESC,AAAA.DIS_YEAR DESC,AAAA.UP_ALLOCATION_NUM,AAAA.FILL_TIME DESC");
			}else {
				//查询本级款项-市
				sql.append("SELECT * FROM (");
				sql.append(" SELECT F.*,F.AMOUNT_BALANCE AMOUNT_EXT_TOTAL,0.0 AMOUNT_EXT_REAL,F.METERIAL_BALANCE METERIAL_EXT_TOTAL,0.0 METERIAL_EXT_REAL,'0' IN_ALREADY_USE");
				sql.append("   FROM DIS_FUNDS_SOURCE F WHERE F.RECEIVE_ORGAN_CODE=? AND F.IN_REF=?  ");
				sql.append("   AND F.SOURCE_ID NOT IN (SELECT S.OLD_SOURCE_ID FROM DIS_FUNDS_SOURCE S WHERE S.END_SOURCE_ID=? AND S.IN_REF=?)");
				
				typeList.add(Types.VARCHAR);
				objList.add(receiveOrganCode);
				typeList.add(Types.VARCHAR);
				objList.add("0");
				typeList.add(Types.VARCHAR);
				objList.add(sourceId);
				typeList.add(Types.VARCHAR);
				objList.add("1");
				if(sourceType.indexOf(",") != -1) {
					sql.append(" AND F.SOURCE_TYPE IN (");
					String[] st = sourceType.split(",");
					for(int j=0; j<st.length; j++) {
						sql.append("?");
						typeList.add(Types.VARCHAR);
						objList.add(st[j]);
						if(j+1!=st.length) {
							sql.append(",");
						}
					}
					sql.append(")");
				}else {
					sql.append(" AND F.SOURCE_TYPE=? ");
					typeList.add(Types.VARCHAR);
					objList.add(sourceType);
				}
				sql.append(" UNION ");
				sql.append(" SELECT AA.*,AA.AMOUNT_BALANCE+FS.AMOUNT AMOUNT_EXT_TOTAL,FS.AMOUNT AMOUNT_EXT_REAL,AA.METERIAL_BALANCE+FS.METERIAL METERIAL_EXT_TOTAL,FS.METERIAL METERIAL_EXT_REAL,'1' IN_ALREADY_USE FROM (");       
				sql.append("  SELECT F.* FROM DIS_FUNDS_SOURCE F WHERE F.RECEIVE_ORGAN_CODE=? AND F.IN_REF=?  ");
				sql.append("    AND F.SOURCE_ID IN (SELECT S.OLD_SOURCE_ID FROM DIS_FUNDS_SOURCE S WHERE S.END_SOURCE_ID=? AND S.IN_REF=?)");
				typeList.add(Types.VARCHAR);
				objList.add(receiveOrganCode);
				typeList.add(Types.VARCHAR);
				objList.add("0");
				typeList.add(Types.VARCHAR);
				objList.add(sourceId);
				typeList.add(Types.VARCHAR);
				objList.add("1");
				if(sourceType.indexOf(",") != -1) {
					sql.append(" AND F.SOURCE_TYPE IN (");
					String[] st = sourceType.split(",");
					for(int j=0; j<st.length; j++) {
						sql.append("?");
						typeList.add(Types.VARCHAR);
						objList.add(st[j]);
						if(j+1!=st.length) {
							sql.append(",");
						}
					}
					sql.append(")");
				}else {
					sql.append(" AND F.SOURCE_TYPE=? ");
					typeList.add(Types.VARCHAR);
					objList.add(sourceType);
				}			
				sql.append("  ) AA LEFT JOIN (SELECT * FROM DIS_FUNDS_SOURCE WHERE END_SOURCE_ID=? AND IN_REF=?) FS ON AA.SOURCE_ID=FS.OLD_SOURCE_ID WHERE FS.END_SOURCE_ID=?"); 
				sql.append(" ) AAA WHERE AAA.AMOUNT_EXT_TOTAL>0 OR AAA.METERIAL_EXT_TOTAL>0 ");
				sql.append(" ORDER BY AAA.AMOUNT_EXT_REAL DESC,AAA.METERIAL_EXT_REAL DESC,AAA.DIS_YEAR DESC,AAA.UP_ALLOCATION_NUM,AAA.FILL_TIME DESC");

				typeList.add(Types.VARCHAR);
				objList.add(sourceId);
				typeList.add(Types.VARCHAR);
				objList.add("1");
				typeList.add(Types.VARCHAR);
				objList.add(sourceId);
			}
		}else if("13".equals(organType)) {
			//获取县级所需数据
			if("0".equals(sourceType)) {
				//查询上级下拨款项-县
				sql.append("SELECT * FROM ");
				sql.append(" (SELECT F.*,F.AMOUNT_BALANCE AMOUNT_EXT_TOTAL,0.0 AMOUNT_EXT_REAL,F.METERIAL_BALANCE METERIAL_EXT_TOTAL,0.0 METERIAL_EXT_REAL");
				sql.append(" FROM DIS_FUNDS_SOURCE F");
				sql.append(" WHERE SOURCE_TYPE=? AND RECEIVE_ORGAN_CODE=? AND IN_REF=? AND IN_USE!=?");
				sql.append(" AND F.SOURCE_ID NOT IN ");
				sql.append(" (SELECT OLD_SOURCE_ID FROM DIS_FUNDS_SOURCE WHERE END_SOURCE_ID=? AND IN_REF=?)");
				typeList.add(Types.VARCHAR);
				objList.add(sourceType);
				typeList.add(Types.VARCHAR);
				objList.add(receiveOrganCode);
				typeList.add(Types.VARCHAR);
				objList.add("0");
				typeList.add(Types.VARCHAR);
				objList.add("9");
				typeList.add(Types.VARCHAR);
				objList.add(sourceId);
				typeList.add(Types.VARCHAR);
				objList.add("1");
				
				sql.append(" UNION ");
				sql.append(" SELECT AAA.*,AAA.AMOUNT_BALANCE+DFS.AMOUNT AMOUNT_EXT_TOTAL,DFS.AMOUNT AMOUNT_EXT_REAL,");
				sql.append(" AAA.METERIAL_BALANCE+DFS.METERIAL METERIAL_EXT_TOTAL,DFS.METERIAL METERIAL_EXT_REAL FROM   ");
				sql.append(" (SELECT F.* FROM DIS_FUNDS_SOURCE F");
				sql.append(" WHERE SOURCE_TYPE=? AND RECEIVE_ORGAN_CODE=? AND IN_REF=? AND IN_USE!=?");
				sql.append(" AND F.SOURCE_ID IN (SELECT OLD_SOURCE_ID FROM DIS_FUNDS_SOURCE WHERE END_SOURCE_ID=? AND IN_REF=?)) AAA ");
				sql.append(" LEFT JOIN (SELECT * FROM DIS_FUNDS_SOURCE");
				sql.append(" WHERE END_SOURCE_ID=? AND IN_REF=?)  DFS ON AAA.SOURCE_ID=DFS.OLD_SOURCE_ID) AAAA");
				sql.append(" WHERE AAAA.AMOUNT_EXT_TOTAL > 0 OR AAAA.METERIAL_EXT_TOTAL > 0 ");
				typeList.add(Types.VARCHAR);
				objList.add(sourceType);
				typeList.add(Types.VARCHAR);
				objList.add(receiveOrganCode);
				typeList.add(Types.VARCHAR);
				objList.add("0");
				typeList.add(Types.VARCHAR);
				objList.add("9");
				typeList.add(Types.VARCHAR);
				objList.add(sourceId);
				typeList.add(Types.VARCHAR);
				objList.add("1");
				typeList.add(Types.VARCHAR);
				objList.add(sourceId);
				typeList.add(Types.VARCHAR);
				objList.add("1");
				
				sql.append(" ORDER BY AAAA.AMOUNT_EXT_REAL DESC,AAAA.METERIAL_EXT_REAL DESC,AAAA.DIS_YEAR DESC,AAAA.UP_ALLOCATION_NUM,AAAA.FILL_TIME DESC");
			}else {
				//查询本级款项-县
				sql.append("SELECT * FROM ");
				sql.append(" (SELECT F.*,F.AMOUNT_BALANCE AMOUNT_EXT_TOTAL,0.0 AMOUNT_EXT_REAL,F.METERIAL_BALANCE METERIAL_EXT_TOTAL,0.0 METERIAL_EXT_REAL");
				sql.append(" FROM DIS_FUNDS_SOURCE F WHERE  RECEIVE_ORGAN_CODE=? AND IN_REF=? AND IN_USE!=?");
				sql.append(" AND F.SOURCE_ID NOT IN (SELECT OLD_SOURCE_ID FROM DIS_FUNDS_SOURCE WHERE END_SOURCE_ID=? AND IN_REF=?)");
				
				typeList.add(Types.VARCHAR);
				objList.add(receiveOrganCode);
				typeList.add(Types.VARCHAR);
				objList.add("0");
				typeList.add(Types.VARCHAR);
				objList.add("9");
				typeList.add(Types.VARCHAR);
				objList.add(sourceId);
				typeList.add(Types.VARCHAR);
				objList.add("1");
				if(sourceType.indexOf(",") != -1) {
					sql.append(" AND F.SOURCE_TYPE IN (");
					String[] st = sourceType.split(",");
					for(int j=0; j<st.length; j++) {
						sql.append("?");
						typeList.add(Types.VARCHAR);
						objList.add(st[j]);
						if(j+1!=st.length) {
							sql.append(",");
						}
					}
					sql.append(")");
				}else {
					sql.append(" AND F.SOURCE_TYPE=? ");
					typeList.add(Types.VARCHAR);
					objList.add(sourceType);
				}
				
				sql.append(" UNION ");
				sql.append(" SELECT AAA.*,AAA.AMOUNT_BALANCE+DFS.AMOUNT AMOUNT_EXT_TOTAL,DFS.AMOUNT AMOUNT_EXT_REAL,");
				sql.append(" AAA.METERIAL_BALANCE+DFS.METERIAL METERIAL_EXT_TOTAL,DFS.METERIAL METERIAL_EXT_REAL FROM");
				sql.append(" (SELECT F.* FROM DIS_FUNDS_SOURCE F");
				sql.append(" WHERE RECEIVE_ORGAN_CODE=? AND IN_REF=? AND IN_USE!=?");
				sql.append(" AND F.SOURCE_ID IN (SELECT OLD_SOURCE_ID FROM DIS_FUNDS_SOURCE WHERE END_SOURCE_ID=? AND IN_REF=?)");
				typeList.add(Types.VARCHAR);
				objList.add(receiveOrganCode);
				typeList.add(Types.VARCHAR);
				objList.add("0");
				typeList.add(Types.VARCHAR);
				objList.add("9");
				typeList.add(Types.VARCHAR);
				objList.add(sourceId);
				typeList.add(Types.VARCHAR);
				objList.add("1");
				if(sourceType.indexOf(",") != -1) {
					sql.append(" AND F.SOURCE_TYPE IN (");
					String[] st = sourceType.split(",");
					for(int j=0; j<st.length; j++) {
						sql.append("?");
						typeList.add(Types.VARCHAR);
						objList.add(st[j]);
						if(j+1!=st.length) {
							sql.append(",");
						}
					}
					sql.append(")");
				}else {
					sql.append(" AND F.SOURCE_TYPE=? ");
					typeList.add(Types.VARCHAR);
					objList.add(sourceType);
				}			
				sql.append(" ) AAA LEFT JOIN (SELECT * FROM DIS_FUNDS_SOURCE"); 
				sql.append(" WHERE END_SOURCE_ID=? AND IN_REF=?) DFS ON AAA.SOURCE_ID=DFS.OLD_SOURCE_ID) AAAA ");
				sql.append(" WHERE AAAA.AMOUNT_EXT_TOTAL>0 OR AAAA.METERIAL_EXT_TOTAL>0");
				typeList.add(Types.VARCHAR);
				objList.add(sourceId);
				typeList.add(Types.VARCHAR);
				objList.add("1");
				
				sql.append(" ORDER BY AAAA.AMOUNT_EXT_REAL DESC,AAAA.METERIAL_EXT_REAL DESC,AAAA.DIS_YEAR DESC,AAAA.UP_ALLOCATION_NUM,AAAA.FILL_TIME DESC");
			}
		}else if("14".equals(organType)) {
			//获取乡级所需数据
			throw new RuntimeException("未知用户所属单位等级！");
		}

		if(typeList.size()>0&&objList.size()>0){
			int[] types = new int[typeList.size()];
			for (int i = 0; i < types.length; i++) {
				types[i]=typeList.get(i);
			}
			Object[] objs = objList.toArray(new Object[objList.size()]);
			DataSet tempDs = this.executeDataset(sql.toString(), types, objs, true);
			
			if(tempDs.getCount()>0) {
				for(int i=0; i<tempDs.getCount(); i++) {
					ds.addRecord(getDisFundsSource(tempDs.getRecord(i)));
				}
			}
		}
		return ds;
	}
	
	//record转bean
	public DisFundsSource getDisFundsSource(Record record) {
		DisFundsSource dataBean = new DisFundsSource();
		dataBean.setSourceId((String) record.get("SOURCE_ID"));
		dataBean.setBatchId((String) record.get("BATCH_ID"));
		dataBean.setDisYear((String) record.get("DIS_YEAR"));
		dataBean.setSourceType((String) record.get("SOURCE_TYPE"));
		dataBean.setUpAllocationNum((String) record.get("UP_ALLOCATION_NUM"));

		dataBean.setUpAllocationType((String) record.get("UP_ALLOCATION_TYPE"));
		dataBean.setUpAllocationPurpose((String) record.get("UP_ALLOCATION_PURPOSE"));
		dataBean.setOldSourceId((String) record.get("OLD_SOURCE_ID"));
		dataBean.setEndSourceId((String) record.get("END_SOURCE_ID"));
		dataBean.setOldUpAllocationNum((String) record.get("OLD_UP_ALLOCATION_NUM"));

		dataBean.setOldUpAllocationType((String) record.get("OLD_UP_ALLOCATION_TYPE"));
		dataBean.setOldUpAllocationPurpose((String) record.get("OLD_UP_ALLOCATION_PURPOSE"));
		dataBean.setReceiveOrganName((String) record.get("RECEIVE_ORGAN_NAME"));
		dataBean.setReceiveOrganCode((String) record.get("RECEIVE_ORGAN_CODE"));
		dataBean.setFillOrganCode((String) record.get("FILL_ORGAN_CODE"));

		dataBean.setFillOrganName((String) record.get("FILL_ORGAN_NAME"));
		dataBean.setFillPeopleName((String) record.get("FILL_PEOPLE_NAME"));
		dataBean.setFillTime((String) record.get("FILL_TIME"));
		dataBean.setUpdatePeopleName((String) record.get("UPDATE_PEOPLE_NAME"));
		dataBean.setUpdateTime((String) record.get("UPDATE_TIME"));
		dataBean.setAmountTotal(new BigDecimal(record.get("AMOUNT_TOTAL").toString()));
		dataBean.setAmount(new BigDecimal(record.get("AMOUNT").toString()));

		dataBean.setMeterial(new BigDecimal(record.get("METERIAL").toString()));
		dataBean.setAmountBalance(new BigDecimal(record.get("AMOUNT_BALANCE").toString()));
		dataBean.setMeterialBalance(new BigDecimal(record.get("METERIAL_BALANCE").toString()));
		if(record.get("AMOUNT_TOTAL_CENTRAL") != null)
			dataBean.setAmountTotalCentral(new BigDecimal(record.get("AMOUNT_TOTAL_CENTRAL").toString()));
		if(record.get("AMOUNT_TOTAL_DEPARTMENT") != null)
			dataBean.setAmountTotalDepartment(new BigDecimal(record.get("AMOUNT_TOTAL_DEPARTMENT").toString()));

		if(record.get("AMOUNT_TOTAL_CITY") != null)
			dataBean.setAmountTotalCity(new BigDecimal(record.get("AMOUNT_TOTAL_CITY").toString()));
		if(record.get("AMOUNT_CITY") != null)
			dataBean.setAmountCity(new BigDecimal(record.get("AMOUNT_CITY").toString()));
		if(record.get("METERIAL_CITY") != null)
			dataBean.setMeterialCity(new BigDecimal(record.get("METERIAL_CITY").toString()));
		if(record.get("AMOUNT_TOTAL_COUNTY") != null)
			dataBean.setAmountTotalCounty(new BigDecimal(record.get("AMOUNT_TOTAL_COUNTY").toString()));
		if(record.get("AMOUNT_COUNTY") != null)
			dataBean.setAmountCounty(new BigDecimal(record.get("AMOUNT_COUNTY").toString()));

		if(record.get("METERIAL_COUNTY") != null)
			dataBean.setMeterialCounty(new BigDecimal(record.get("METERIAL_COUNTY").toString()));
		dataBean.setFundsType((String) record.get("FUNDS_TYPE"));
		dataBean.setInRef((String) record.get("IN_REF"));
		dataBean.setInUse((String) record.get("IN_USE"));
		
		dataBean.setAmountExtTotal(new BigDecimal(record.get("AMOUNT_EXT_TOTAL").toString()));
		dataBean.setAmountExtReal(new BigDecimal(record.get("AMOUNT_EXT_REAL").toString()));
		dataBean.setMeterialExtTotal(new BigDecimal(record.get("METERIAL_EXT_TOTAL").toString()));
		dataBean.setMeterialExtReal(new BigDecimal(record.get("METERIAL_EXT_REAL").toString()));
		
		dataBean.setOldFundsType((String) record.get("OLD_FUNDS_TYPE"));
		dataBean.setMidUpAllocationNum((String) record.get("MID_UP_ALLOCATION_NUM"));
		dataBean.setMidUpAllocationNumNext((String) record.get("MID_UP_ALLOCATION_NUM_NEXT"));
		
		dataBean.setInAlreadyUse((String) record.get("IN_ALREADY_USE"));
		return dataBean;
	}
	
	
	/**
	 * @Description: 关系数据的资金返还给源编码-重置关系数据-根据目的记录
	 * @author xuexzh
	 */
	public void resetRef(DisFundsSource disFundsSource) {
		String organType = BspUtil.getOrganType();//当前登录人所属组织类型
		//获取本明细所有的拨付关系(仅获取中央和省级的关系)
		String sql = "SELECT * FROM DIS_FUNDS_SOURCE WHERE END_SOURCE_ID=? AND IN_REF=? AND OLD_FUNDS_TYPE IN(?,?)";
		int[] types=new int[4];
		types[0]=Types.VARCHAR;
		types[1]=Types.VARCHAR;
		types[2]=Types.VARCHAR;
		types[3]=Types.VARCHAR;
		Object[] args = new Object[4];
		args[0]=disFundsSource.getSourceId();
		args[1]="1";
		args[2]="0";
		args[3]="1";
		DataSet ds = this.executeDataset(sql, types, args, true);
		if(ds.getCount()>0) {
			//逐个更新拨付关系对应的源明细的值（回加）
			String innerSql="UPDATE DIS_FUNDS_SOURCE SET AMOUNT_BALANCE=AMOUNT_BALANCE+?,METERIAL_BALANCE=METERIAL_BALANCE+?,UPDATE_PEOPLE_NAME=?,UPDATE_TIME=? WHERE SOURCE_ID=?";
			int[] types2 = new int[5];
			types2[0] = Types.DECIMAL;
			types2[1] = Types.DECIMAL;
			types2[2] = Types.VARCHAR;
			types2[3] = Types.VARCHAR;
			types2[4] = Types.VARCHAR;
			Object[] args2 = new Object[5];
			args2[0] = 0;
			args2[1] = 0;
			args2[2] = disFundsSource.getUpdatePeopleName();
			args2[3] = disFundsSource.getUpdateTime();
			args2[4] = "";

			List<Integer> typeList = new ArrayList<Integer>();
			List<Object> objList = new ArrayList<Object>();
			for(int i=0; i<ds.getCount(); i++) {
				Record record = ds.getRecord(i);
				args2[0] = new BigDecimal(record.get("AMOUNT").toString());
				args2[1] = new BigDecimal(record.get("METERIAL").toString());
				String sId = (String)record.get("OLD_SOURCE_ID");
				args2[4] = sId;
				typeList.add(Types.VARCHAR);
				objList.add(sId);
				executeUpdate(innerSql, types2, args2);
			}

			StringBuffer sqlEnd = new StringBuffer();
			StringBuffer sqlMid = new StringBuffer();
			//验证所有的源数据是否存在未拨付的情况（即资金=结余）
			sqlEnd.append("UPDATE DIS_FUNDS_SOURCE SET IN_USE='0' WHERE AMOUNT=AMOUNT_BALANCE AND METERIAL=METERIAL_BALANCE AND SOURCE_ID IN(");
			int[] typesEnd = new int[typeList.size()];
			for (int i = 0; i < typesEnd.length; i++) {
				typesEnd[i] = typeList.get(i);
				sqlEnd.append("?");
				sqlMid.append("?");
				if(i != typesEnd.length-1) {
					sqlEnd.append(",");
					sqlMid.append(",");
				}
			}
			sqlEnd.append(")");
			sqlMid.append(")");
			Object[] argsEnd = objList.toArray(new Object[objList.size()]);
			executeUpdate(sqlEnd.toString(), typesEnd, argsEnd);
			
			if("12".equals(organType)) {
				//如果是市级，重新计算中间数据
				sqlMid.insert(0, "SELECT DISTINCT END_SOURCE_ID FROM DIS_FUNDS_SOURCE WHERE END_SOURCE_ID IS NOT NULL AND SOURCE_ID IN(");
				Set<Object> refMidSourceIdSet = new HashSet<Object>();
				DataSet midDs = executeDataset(sqlMid.toString(), typesEnd, argsEnd, true);
				if(midDs.getCount()>0) {
					for(int k=0;k<midDs.getCount();k++) {
						refMidSourceIdSet.add((String)(midDs.getRecord(k).get("END_SOURCE_ID")));
					}
					reComputeMid(refMidSourceIdSet);
				}
				
			}
		}
	}
	
	/**
	 * @Description: 关系数据的资金返还给源编码-重置关系数据-根据源记录
	 * @author xuexzh
	 */
	public void resetRefByOld(DisFundsSource oldDisFundsSource, DisFundsSource disFundsSource) {
		String organType = BspUtil.getOrganType();//当前登录人所属组织类型
		//获取本明细所有的拨付关系
		String sql = "SELECT * FROM DIS_FUNDS_SOURCE WHERE OLD_SOURCE_ID=? AND END_SOURCE_ID=? AND IN_REF=?";
		int[] types=new int[3];
		types[0]=Types.VARCHAR;
		types[1]=Types.VARCHAR;
		types[2]=Types.VARCHAR;
		Object[] args = new Object[3];
		args[0]=oldDisFundsSource.getSourceId();
		args[1]=disFundsSource.getSourceId();
		args[2]="1";
		DataSet ds = this.executeDataset(sql, types, args, true);
		if(ds.getCount()>0) {
			//逐个更新拨付关系对应的源明细的值（回加）
			String innerSql="UPDATE DIS_FUNDS_SOURCE SET AMOUNT_BALANCE=AMOUNT_BALANCE+?,METERIAL_BALANCE=METERIAL_BALANCE+?,UPDATE_PEOPLE_NAME=?,UPDATE_TIME=? WHERE SOURCE_ID=?";
			int[] types2 = new int[5];
			types2[0] = Types.DECIMAL;
			types2[1] = Types.DECIMAL;
			types2[2] = Types.VARCHAR;
			types2[3] = Types.VARCHAR;
			types2[4] = Types.VARCHAR;
			Object[] args2 = new Object[5];
			args2[0] = 0;
			args2[1] = 0;
			args2[2] = oldDisFundsSource.getUpdatePeopleName();
			args2[3] = oldDisFundsSource.getUpdateTime();
			args2[4] = "";

			List<Integer> typeList = new ArrayList<Integer>();
			List<Object> objList = new ArrayList<Object>();
			for(int i=0; i<ds.getCount(); i++) {
				Record record = ds.getRecord(i);
				args2[0] = new BigDecimal(record.get("AMOUNT").toString());
				args2[1] = new BigDecimal(record.get("METERIAL").toString());
				args2[4] = oldDisFundsSource.getSourceId();
				executeUpdate(innerSql, types2, args2);
			}

			StringBuffer sqlEnd = new StringBuffer();
			//验证所有的源数据是否存在未拨付的情况（即资金=结余）
			sqlEnd.append("UPDATE DIS_FUNDS_SOURCE SET IN_USE='0' WHERE AMOUNT=AMOUNT_BALANCE AND METERIAL=METERIAL_BALANCE AND SOURCE_ID=?");
			int[] typesEnd = new int[1];
			types2[0] = Types.VARCHAR;
			Object[] argsEnd = new Object[1];
			args2[0] = oldDisFundsSource.getSourceId();
			executeUpdate(sqlEnd.toString(), typesEnd, argsEnd);
			//可重新计算物资总和,暂时不用
		}
	}
	
	/**
	 * @Description: 删除关系数据-至临时表
	 * @author xuexzh
	 */
	public void deleteRef(DisFundsSource disFundsSource) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		StringBuffer sql2 = new StringBuffer();
		//转移所有的关系至临时表，清空主表中的关系（仅清除中央和省级的关系）
		sql.append("INSERT INTO DIS_FUNDS_SOURCE_BAK SELECT * FROM DIS_FUNDS_SOURCE WHERE END_SOURCE_ID=? AND IN_REF=? AND OLD_FUNDS_TYPE IN(?,?)");
		sql2.append("DELETE FROM DIS_FUNDS_SOURCE WHERE END_SOURCE_ID=? AND IN_REF=? AND OLD_FUNDS_TYPE IN(?,?)");
		typeList.add(Types.VARCHAR);
		objList.add(disFundsSource.getSourceId());
		typeList.add(Types.VARCHAR);
		objList.add("1");
		typeList.add(Types.VARCHAR);
		objList.add("0");
		typeList.add(Types.VARCHAR);
		objList.add("1");

		if(typeList.size()>0&&objList.size()>0){
			int[] types = new int[typeList.size()];
			for (int i = 0; i < types.length; i++) {
				types[i]=typeList.get(i);
			}
			Object[] objs = objList.toArray(new Object[objList.size()]);
			this.executeUpdate(sql.toString(), types, objs);
			this.executeUpdate(sql2.toString(), types, objs);
		}
	}
	
	/**
	 * @Description: 确认拨付
	 * @author xuexzh
	 */
	public void confirmAllocation(DisFundsSourceBatch disFundsSourceBatch) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		//1.重置批次里所有明细的拨付状态（IN_USE=9->0）
		sql.append("UPDATE DIS_FUNDS_SOURCE SET UPDATE_PEOPLE_NAME=?,UPDATE_TIME=?,IN_USE=? WHERE BATCH_ID=?");
		typeList.add(Types.VARCHAR);
		objList.add(disFundsSourceBatch.getConfirmPeopleName());
		typeList.add(Types.VARCHAR);
		objList.add(disFundsSourceBatch.getConfirmTime());
		typeList.add(Types.VARCHAR);
		objList.add("0");
		typeList.add(Types.VARCHAR);
		objList.add(disFundsSourceBatch.getBatchId());
		
		if(typeList.size()>0&&objList.size()>0){
			int[] types = new int[typeList.size()];
			for (int i = 0; i < types.length; i++) {
				types[i]=typeList.get(i);
			}
			Object[] objs = objList.toArray(new Object[objList.size()]);
			this.executeUpdate(sql.toString(), types, objs);
		}

		//2.当确认拨付后，删除拨付资金为0的明细（即本次未拨付资金于此单位）
		sql.delete(0, sql.length());
		sql.append("DELETE DIS_FUNDS_SOURCE WHERE BATCH_ID=? AND IN_REF=? AND ((AMOUNT_TOTAL=? AND AMOUNT=? AND METERIAL=?) OR (AMOUNT_TOTAL IS NULL AND AMOUNT IS NULL AND METERIAL IS NULL))");
		typeList.clear();
		objList.clear();
		BigDecimal zero = new BigDecimal(0.0);
		typeList.add(Types.VARCHAR);
		objList.add(disFundsSourceBatch.getBatchId());
		typeList.add(Types.VARCHAR);
		objList.add("0");
		typeList.add(Types.DECIMAL);
		objList.add(zero);
		typeList.add(Types.DECIMAL);
		objList.add(zero);
		typeList.add(Types.DECIMAL);
		objList.add(zero);
		if(typeList.size()>0&&objList.size()>0){
			int[] types = new int[typeList.size()];
			for (int i = 0; i < types.length; i++) {
				types[i]=typeList.get(i);
			}
			Object[] objs = objList.toArray(new Object[objList.size()]);
			this.executeUpdate(sql.toString(), types, objs);
		}
	}
	
	/**
	 * @Description: 删除批次
	 * @author xuexzh
	 */
	public void deleteAllocation(DisFundsSourceBatch disFundsSourceBatch) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		//1. 重置本批次下所有明细的使用源的值-先查询，后逐个重置
		ParameterSet pset = new ParameterSet();
		pset.setParameter("BATCH_ID", disFundsSourceBatch.getBatchId());
		pset.setParameter("IN_REF", "0");
		DataSet ds= query(pset);
		if(ds.getCount() > 0) {
			for(int i=0; i<ds.getCount(); i++) {
				DisFundsSource tempDfs = (DisFundsSource)ds.getRecord(i).toBean(DisFundsSource.class);
				resetRef(tempDfs);
			}
		}
		
		//2. 删除批次内所有的明细及关系
		sql.append("DELETE DIS_FUNDS_SOURCE WHERE BATCH_ID=?");
		typeList.add(Types.VARCHAR);
		objList.add(disFundsSourceBatch.getBatchId());
		
		if(typeList.size()>0&&objList.size()>0){
			int[] types = new int[typeList.size()];
			for (int i = 0; i < types.length; i++) {
				types[i]=typeList.get(i);
			}
			Object[] objs = objList.toArray(new Object[objList.size()]);
			this.executeUpdate(sql.toString(), types, objs);
		}
	}
	
	/**
	 * @Description: 重新计算中间数据(仅市级)
	 * @author xuexzh
	 */
	public void reComputeMid(Set<Object> refMidSourceIdSet) {
		String sql = "UPDATE DIS_FUNDS_SOURCE SET UPDATE_PEOPLE_NAME=?,UPDATE_TIME=?,AMOUNT_BALANCE=(SELECT NVL(SUM(AMOUNT),0) FROM DIS_FUNDS_SOURCE WHERE END_SOURCE_ID=?),METERIAL_BALANCE=(SELECT NVL(SUM(METERIAL),0) FROM DIS_FUNDS_SOURCE WHERE END_SOURCE_ID=?) WHERE SOURCE_ID=?";
		int[] types=new int[5];
		types[0]=Types.VARCHAR;
		types[1]=Types.VARCHAR;
		types[2]=Types.VARCHAR;
		types[3]=Types.VARCHAR;
		types[4]=Types.VARCHAR;
		Object[] args = new Object[5];
		args[0]=GetBspInfo.getBspInfo().getUserName();
		args[1]=DateUtil.getTime();
		
		if(refMidSourceIdSet != null && refMidSourceIdSet.size() > 0) {
			for (Iterator<Object> iter = refMidSourceIdSet.iterator(); iter.hasNext();) {
				String sid = (String) iter.next();
				args[2]=sid;
				args[3]=sid;
				args[4]=sid;
				this.executeUpdate(sql, types, args);
			}
		}
	}
	
	/**
	 * @Description: 查询资金-单条
	 * @author xuexzh
	 */
	public DataSet queryFundsSingle(ParameterSet pset) {
		String sourceId = (String) pset.get("sourceId");
		String currentSourceId = (String) pset.get("currentSourceId");
//		String batchId = (String) pset.get("batchId");
		String inRef = (String) pset.get("inRef");
		DataSet ds = new DataSet();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		
		if("0".equals(inRef)) {
			//无关系数据
			sql.append("SELECT F.*,F.AMOUNT_BALANCE AMOUNT_EXT_TOTAL,0.0 AMOUNT_EXT_REAL,F.METERIAL_BALANCE METERIAL_EXT_TOTAL,0.0 METERIAL_EXT_REAL");
			sql.append(" FROM DIS_FUNDS_SOURCE F WHERE SOURCE_ID=? AND IN_REF=?");
			typeList.add(Types.VARCHAR);
			objList.add(sourceId);
			typeList.add(Types.VARCHAR);
			objList.add("0");
		}else if("1".equals(inRef)) {
			//有关系数据
			sql.append("SELECT AA.*,AA.AMOUNT_BALANCE+NVL(FS.AMOUNT,0) AMOUNT_EXT_TOTAL,NVL(FS.AMOUNT,0) AMOUNT_EXT_REAL,AA.METERIAL_BALANCE+NVL(FS.METERIAL,0) METERIAL_EXT_TOTAL,NVL(FS.METERIAL,0) METERIAL_EXT_REAL");
			sql.append(" FROM (SELECT F.* FROM DIS_FUNDS_SOURCE F WHERE F.SOURCE_ID=? AND IN_REF=?) AA");
			sql.append(" LEFT JOIN (SELECT * FROM DIS_FUNDS_SOURCE WHERE END_SOURCE_ID=? AND OLD_SOURCE_ID=? ");
			sql.append(" AND IN_REF=?) FS ON AA.SOURCE_ID = FS.OLD_SOURCE_ID");
			
			typeList.add(Types.VARCHAR);
			objList.add(sourceId);
			typeList.add(Types.VARCHAR);
			objList.add("0");
			typeList.add(Types.VARCHAR);
			objList.add(currentSourceId);
			typeList.add(Types.VARCHAR);
			objList.add(sourceId);
			typeList.add(Types.VARCHAR);
			objList.add("1");
		}
		
		if(typeList.size()>0&&objList.size()>0){
			int[] types = new int[typeList.size()];
			for (int i = 0; i < types.length; i++) {
				types[i]=typeList.get(i);
			}
			Object[] objs = objList.toArray(new Object[objList.size()]);
			DataSet tempDs = this.executeDataset(sql.toString(), types, objs, true);
			
			if(tempDs.getCount()>0) {
				for(int i=0; i<tempDs.getCount(); i++) {
					ds.addRecord(getDisFundsSource(tempDs.getRecord(i)));
				}
			}
		}
		return ds;
	}

	/**
	 * @Description: 删除关系数据-至临时表-根据源数据
	 * @author xuexzh
	 */
	public void deleteRefByOld(DisFundsSource oldDisFundsSource, DisFundsSource disFundsSource) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		StringBuffer sql2 = new StringBuffer();
		//转移所有的关系至临时表，清空主表中的关系
		sql.append("INSERT INTO DIS_FUNDS_SOURCE_BAK SELECT * FROM DIS_FUNDS_SOURCE WHERE OLD_SOURCE_ID=? AND END_SOURCE_ID=? AND IN_REF=?");
		sql2.append("DELETE FROM DIS_FUNDS_SOURCE WHERE OLD_SOURCE_ID=? AND END_SOURCE_ID=? AND IN_REF=?");
		typeList.add(Types.VARCHAR);
		objList.add(oldDisFundsSource.getSourceId());
		typeList.add(Types.VARCHAR);
		objList.add(disFundsSource.getSourceId());
		typeList.add(Types.VARCHAR);
		objList.add("1");
		if(typeList.size()>0&&objList.size()>0){
			int[] types = new int[typeList.size()];
			for (int i = 0; i < types.length; i++) {
				types[i]=typeList.get(i);
			}
			Object[] objs = objList.toArray(new Object[objList.size()]);
			this.executeUpdate(sql.toString(), types, objs);
			this.executeUpdate(sql2.toString(), types, objs);
		}
	}
	
	/**
	 * @Description: 重新计算单条信息
	 * @author xuexzh
	 */
	public void reCompute(DisFundsSource disFundsSource, String actionFundsType) {
		//actionFundsType 标志拨付款项的等级(仅县级)：市款为2，县款为3
		String organType = BspUtil.getOrganType();
		if(!"12".equals(organType) && !"13".equals(organType)) {
			//仅市级/县级可用此功能
			throw new RuntimeException("非此登录单位的功能，不能使用！");
		}
		//更新当前记录的资金汇总和物资汇总
		String sql = "UPDATE DIS_FUNDS_SOURCE SET UPDATE_PEOPLE_NAME=?,UPDATE_TIME=?,AMOUNT_BALANCE=(SELECT NVL(SUM(AMOUNT),0) FROM DIS_FUNDS_SOURCE WHERE END_SOURCE_ID=?),METERIAL_BALANCE=(SELECT NVL(SUM(METERIAL),0) FROM DIS_FUNDS_SOURCE WHERE END_SOURCE_ID=?) WHERE SOURCE_ID=?";
		int[] types=new int[5];
		types[0]=Types.VARCHAR;
		types[1]=Types.VARCHAR;
		types[2]=Types.VARCHAR;
		types[3]=Types.VARCHAR;
		types[4]=Types.VARCHAR;
		Object[] args = new Object[5];
		args[0]=disFundsSource.getUpdatePeopleName();
		args[1]=disFundsSource.getUpdateTime();
		args[2]=disFundsSource.getSourceId();
		args[3]=disFundsSource.getSourceId();
		args[4]=disFundsSource.getSourceId();
		this.executeUpdate(sql, types, args);
		
		//更新此当前记录的各级明细（市、县）
		String sql2;
		int[] types2=new int[5];
		types2[0]=Types.VARCHAR;
		types2[1]=Types.VARCHAR;
		types2[2]=Types.VARCHAR;
		types2[3]=Types.VARCHAR;
		types2[4]=Types.VARCHAR;
		Object[] args2 = new Object[5];
		args2[0]=disFundsSource.getSourceId();
		args2[2]=disFundsSource.getSourceId();
		args2[4]=disFundsSource.getSourceId();

		String sql3;
		String sql4;
		int[] types3=new int[1];
		types3[0]=Types.VARCHAR;
		Object[] args3 = new Object[1];
		args3[0]=disFundsSource.getSourceId();
		
		if("12".equals(organType)){
			sql2 = "UPDATE DIS_FUNDS_SOURCE SET AMOUNT_CITY=(SELECT NVL(SUM(AMOUNT),0) FROM DIS_FUNDS_SOURCE WHERE END_SOURCE_ID=? AND OLD_FUNDS_TYPE=?),METERIAL_CITY=(SELECT NVL(SUM(METERIAL),0) FROM DIS_FUNDS_SOURCE WHERE END_SOURCE_ID=? AND OLD_FUNDS_TYPE=?) WHERE SOURCE_ID=?";
			sql3 = "UPDATE DIS_FUNDS_SOURCE SET AMOUNT=AMOUNT_BALANCE,METERIAL=METERIAL_BALANCE,AMOUNT_TOTAL_CITY=AMOUNT_CITY+METERIAL_CITY WHERE SOURCE_ID=?";
			sql4 = "UPDATE DIS_FUNDS_SOURCE SET AMOUNT_TOTAL=AMOUNT+METERIAL WHERE SOURCE_ID=?";
			args2[1]="2";
			args2[3]="2";
		}else if("13".equals(organType)){
			sql3 = "UPDATE DIS_FUNDS_SOURCE SET AMOUNT=AMOUNT_BALANCE,METERIAL=METERIAL_BALANCE,AMOUNT_TOTAL_COUNTY=AMOUNT_COUNTY+METERIAL_COUNTY WHERE SOURCE_ID=?";
			sql4 = "UPDATE DIS_FUNDS_SOURCE SET AMOUNT_TOTAL=AMOUNT+METERIAL WHERE SOURCE_ID=?";
			
			//如果是县拨市款，则合计入市拨，如果是县拨县款，则合计入县拨
			if(actionFundsType.equals("2")) {
				sql2 = "UPDATE DIS_FUNDS_SOURCE SET AMOUNT_CITY=(SELECT NVL(SUM(AMOUNT),0) FROM DIS_FUNDS_SOURCE WHERE END_SOURCE_ID=? AND OLD_FUNDS_TYPE=?),METERIAL_CITY=(SELECT NVL(SUM(METERIAL),0) FROM DIS_FUNDS_SOURCE WHERE END_SOURCE_ID=? AND OLD_FUNDS_TYPE=?) WHERE SOURCE_ID=?";
			}else if(actionFundsType.equals("3")) {
				sql2 = "UPDATE DIS_FUNDS_SOURCE SET AMOUNT_COUNTY=(SELECT NVL(SUM(AMOUNT),0) FROM DIS_FUNDS_SOURCE WHERE END_SOURCE_ID=? AND OLD_FUNDS_TYPE=?),METERIAL_COUNTY=(SELECT NVL(SUM(METERIAL),0) FROM DIS_FUNDS_SOURCE WHERE END_SOURCE_ID=? AND OLD_FUNDS_TYPE=?) WHERE SOURCE_ID=?";
			}else {
				throw new RuntimeException("标志拨付款项的等级错误！");
			}
			args2[1]=actionFundsType;
			args2[3]=actionFundsType;
		}else {
			throw new RuntimeException("非此登录单位的功能，不能使用！");
		}
		
		this.executeUpdate(sql2, types2, args2);
		this.executeUpdate(sql3, types3, args3);
		this.executeUpdate(sql4, types3, args3);
	}
	
	/**
	 * @Description: 重新计算单条记录
	 * @author xuexzh
	 */
	public void resetRefBySwap(DisFundsSource disFundsSource) {
		//获取本明细所有的拨付关系(仅获取中央和省级的关系)
		String sql = "SELECT * FROM DIS_FUNDS_SOURCE WHERE END_SOURCE_ID=? AND IN_REF=?";
		int[] types=new int[2];
		types[0]=Types.VARCHAR;
		types[1]=Types.VARCHAR;
		Object[] args = new Object[2];
		args[0]=disFundsSource.getSourceId();
		args[1]="1";
		DataSet ds = this.executeDataset(sql, types, args, true);
		if(ds.getCount()>0) {
			//逐个更新拨付关系对应的源明细的值（回加）
			String innerSql="UPDATE DIS_FUNDS_SOURCE SET AMOUNT_BALANCE=AMOUNT_BALANCE+?,METERIAL_BALANCE=METERIAL_BALANCE+?,UPDATE_PEOPLE_NAME=?,UPDATE_TIME=? WHERE SOURCE_ID=?";
			int[] types2 = new int[5];
			types2[0] = Types.DECIMAL;
			types2[1] = Types.DECIMAL;
			types2[2] = Types.VARCHAR;
			types2[3] = Types.VARCHAR;
			types2[4] = Types.VARCHAR;
			Object[] args2 = new Object[5];
			args2[0] = 0;
			args2[1] = 0;
			args2[2] = disFundsSource.getUpdatePeopleName();
			args2[3] = disFundsSource.getUpdateTime();
			args2[4] = "";

			List<Integer> typeList = new ArrayList<Integer>();
			List<Object> objList = new ArrayList<Object>();
			for(int i=0; i<ds.getCount(); i++) {
				Record record = ds.getRecord(i);
				args2[0] = new BigDecimal(record.get("AMOUNT").toString());
				args2[1] = new BigDecimal(record.get("METERIAL").toString());
				String sId = (String)record.get("OLD_SOURCE_ID");
				args2[4] = sId;
				typeList.add(Types.VARCHAR);
				objList.add(sId);
				executeUpdate(innerSql, types2, args2);
			}

			StringBuffer sqlEnd = new StringBuffer();
			StringBuffer sqlMid = new StringBuffer();
			//验证所有的源数据是否存在未拨付的情况（即资金=结余）
			sqlEnd.append("UPDATE DIS_FUNDS_SOURCE SET IN_USE='0' WHERE AMOUNT=AMOUNT_BALANCE AND METERIAL=METERIAL_BALANCE AND SOURCE_ID IN(");
			int[] typesEnd = new int[typeList.size()];
			for (int i = 0; i < typesEnd.length; i++) {
				typesEnd[i] = typeList.get(i);
				sqlEnd.append("?");
				sqlMid.append("?");
				if(i != typesEnd.length-1) {
					sqlEnd.append(",");
					sqlMid.append(",");
				}
			}
			sqlEnd.append(")");
			sqlMid.append(")");
			Object[] argsEnd = objList.toArray(new Object[objList.size()]);
			executeUpdate(sqlEnd.toString(), typesEnd, argsEnd);
		}
	}
	
	/**
	 * @Description: 删除关系数据-至临时表-置换
	 * @author xuexzh
	 */
	public void deleteRefBySwap(DisFundsSource disFundsSource) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		StringBuffer sql2 = new StringBuffer();
		//转移所有的关系至临时表，清空主表中的关系（仅清除中央和省级的关系）
		sql.append("INSERT INTO DIS_FUNDS_SOURCE_BAK SELECT * FROM DIS_FUNDS_SOURCE WHERE END_SOURCE_ID=? AND IN_REF=?");
		sql2.append("DELETE FROM DIS_FUNDS_SOURCE WHERE END_SOURCE_ID=? AND IN_REF=?");
		typeList.add(Types.VARCHAR);
		objList.add(disFundsSource.getSourceId());
		typeList.add(Types.VARCHAR);
		objList.add("1");

		if(typeList.size()>0&&objList.size()>0){
			int[] types = new int[typeList.size()];
			for (int i = 0; i < types.length; i++) {
				types[i]=typeList.get(i);
			}
			Object[] objs = objList.toArray(new Object[objList.size()]);
			this.executeUpdate(sql.toString(), types, objs);
			this.executeUpdate(sql2.toString(), types, objs);
		}
	}
	
	/**
	 * @Description: 验证是否已使用
	 * @author xuexzh
	 */

	public boolean validateIsUse(DisFundsSource disFundsSource) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		//获取所有原关系
		String sql = "SELECT * FROM DIS_FUNDS_SOURCE WHERE OLD_SOURCE_ID=? AND IN_REF=?";
		typeList.add(Types.VARCHAR);
		objList.add(disFundsSource.getSourceId());
		typeList.add(Types.VARCHAR);
		objList.add("1");
		
		if(typeList.size()>0&&objList.size()>0){
			int[] types = new int[typeList.size()];
			for (int i = 0; i < types.length; i++) {
				types[i]=typeList.get(i);
			}
			Object[] objs = objList.toArray(new Object[objList.size()]);
			DataSet ds = executeDataset(sql.toString(), types, objs, true);
			if(ds.getCount()>0)
				return true;
			else 
				return false;
		}
		return true;
	}

	public String queryFundsAndBudget(ParameterSet parameterSet) {
		String organCode = (String) parameterSet.get("organCode");
		String disYear = (String) parameterSet.get("disYear");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		//获取所有原关系
		String sql = "SELECT NVL(SUM(AMOUNT_TOTAL),0) AMOUNT_TOTAL FROM DIS_FUNDS_SOURCE WHERE SOURCE_TYPE=? AND DIS_YEAR=? AND IN_REF=? AND RECEIVE_ORGAN_CODE=?";
		typeList.add(Types.VARCHAR);
		objList.add("1");
		typeList.add(Types.VARCHAR);
		objList.add(disYear);
		typeList.add(Types.VARCHAR);
		objList.add("0");
		typeList.add(Types.VARCHAR);
		objList.add(organCode);
		
		int[] types = new int[typeList.size()];
		for (int i = 0; i < types.length; i++) {
			types[i]=typeList.get(i);
		}
		Object[] objs = objList.toArray(new Object[objList.size()]);
		Object[] fundsTotalObject = executeDetail(sql, types, objs);
		
		typeList.clear();
		objList.clear();
		String sql2 = "SELECT NVL(SUM(BUDGET_MONEY),0) AMOUNT_TOTAL FROM DIS_FUNDS_YEAR_BUDGET WHERE DIS_YEAR=? AND FILL_ORGAN_CODE=?";
		typeList.add(Types.VARCHAR);
		objList.add(disYear);
		typeList.add(Types.VARCHAR);
		objList.add(organCode);
		
		int[] types2 = new int[typeList.size()];
		for (int i = 0; i < types2.length; i++) {
			types2[i]=typeList.get(i);
		}
		Object[] objs2 = objList.toArray(new Object[objList.size()]);
		Object[] budgetTotalObject = executeDetail(sql2, types2, objs2);	
		
		BigDecimal fundsTotal = new BigDecimal(fundsTotalObject[0].toString());
		BigDecimal budgetTotal = new BigDecimal(budgetTotalObject[0].toString());
		return fundsTotal.doubleValue()+","+budgetTotal.doubleValue();
	}

	/**
	 * @Description: 分配统计
	 * @author xuexzh
	 */
	public DataSet queryAllocationForSums(ParameterSet pset) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("procedureName", "DIS_QUERY_FUNDS_ALLOCATION");
		map.put("parameterNum", 2);
		map.put("parameterName_1", "in_area_code");
		map.put("parameterName_2", "in_year");
		map.put("NumberOfResultSet", 1);
		Proc procduce = new ProceduresUtil().init(getDataSource(), map);
		DataSet set = new DataSet();
		List results = null;
		Object object = null;
		String qOrganCode = (String) pset.getParameter("qOrganCode");
		String qDisYear = (String) pset.getParameter("qDisYear");
		map.put("parameterValue_1", qOrganCode);
		map.put("parameterValue_2", qDisYear);
		
		object = procduce.call(map).get("results");
		if (object instanceof ArrayList) {
			results = (List) object;
			for (Object o : results) {
				set.add((Record) o);
			}
		}
		ProceduresUtil.fixDataSet(set);
		return set;
	}

	/**
	 * @Description: 置换统计
	 * @author xuexzh
	 */
	public DataSet querySwapGoodsForSums(ParameterSet pset) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("procedureName", "DIS_QUERY_GOODS_SWAP");
		map.put("parameterNum", 2);
		map.put("parameterName_1", "in_area_code");
		map.put("parameterName_2", "in_year");
		map.put("NumberOfResultSet", 1);
		Proc procduce = new ProceduresUtil().init(getDataSource(), map);
		DataSet set = new DataSet();
		List results = null;
		Object object = null;
		String qOrganCode = (String) pset.getParameter("qOrganCode");
		String qDisYear = (String) pset.getParameter("qDisYear");
		map.put("parameterValue_1", qOrganCode);
		map.put("parameterValue_2", qDisYear);
		
		object = procduce.call(map).get("results");
		if (object instanceof ArrayList) {
			results = (List) object;
			for (Object o : results) {
				set.add((Record) o);
			}
		}
		ProceduresUtil.fixDataSet(set);
		return set;
	}

	/**
	 * @Description: 结余统计
	 * @author xuexzh
	 */
	public DataSet queryFundsBalance(ParameterSet pset) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("procedureName", "DIS_QUERY_FUNDS_BALANCE");
		map.put("parameterNum", 1);
		map.put("parameterName_1", "in_area_code");
		map.put("NumberOfResultSet", 1);
		Proc procduce = new ProceduresUtil().init(getDataSource(), map);
		DataSet set = new DataSet();
		List results = null;
		Object object = null;
		String qOrganCode = (String) pset.getParameter("qOrganCode");
		map.put("parameterValue_1", qOrganCode);
		
		object = procduce.call(map).get("results");
		if (object instanceof ArrayList) {
			results = (List) object;
			for (Object o : results) {
				set.add((Record) o);
			}
		}
		ProceduresUtil.fixDataSet(set);
		return set;
	}
}