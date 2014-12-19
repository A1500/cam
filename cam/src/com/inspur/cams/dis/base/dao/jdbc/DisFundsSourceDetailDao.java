package com.inspur.cams.dis.base.dao.jdbc;

import java.math.BigDecimal;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.dis.base.dao.IDisFundsSourceDetailDao;
import com.inspur.cams.dis.base.data.DisFundsSource;
import com.inspur.cams.dis.base.data.DisFundsSourceBatch;
import com.inspur.cams.dis.base.data.DisFundsSourceDetail;

/**
 * 资金拨付明细表dao
 * @author 
 * @date 2013-01-04
 */
public class DisFundsSourceDetailDao extends EntityDao<DisFundsSourceDetail> implements IDisFundsSourceDetailDao {
	
	@Override
	public Class<DisFundsSourceDetail> getEntityClass() {
		return DisFundsSourceDetail.class;
	}
	
	/**
	 * @Description: 根据主表主键删除数据
	 * @author xuexzh
	 */
	public void deleteByRef(String sourceId) {
		int[] types = new int[1];
		types[0] = Types.VARCHAR;
		Object[] args = new Object[1];
		args[0] = sourceId;
		executeUpdate("DELETE FROM DIS_FUNDS_SOURCE_DETAIL WHERE SOURCE_ID=?", types, args);
	}

	/**
	 * @Description: 查询物资明细
	 * @author xuexzh
	 */
	public DataSet queryFundsDetails(ParameterSet pset) {
		String sourceId = (String) pset.get("sourceId");
		String organType = (String) pset.get("organType");
		String currentSourceId = (String) pset.get("currentSourceId");
//		String batchId = (String) pset.get("batchId");
		String fundsType = (String) pset.get("fundsType");
		String actionFundsType = (String) pset.get("actionFundsType");
		String inRef = (String) pset.get("inRef");

		DataSet ds = new DataSet();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();

		if("12".equals(organType)) {
			//市级
			if("0".equals(inRef)) {
				//无关系数据-市
				sql.append("SELECT F.*,F.METERIAL_NUM_BALANCE REAL_METERIAL_NUM_TOTAL,F.METERIAL_ACCOUNT_BALANCE REAL_METERIAL_ACCOUNT_TOTAL,0.0 REAL_METERIAL_NUM,0.0 REAL_METERIAL_ACCOUNT");
				sql.append(" FROM DIS_FUNDS_SOURCE_DETAIL F WHERE SOURCE_ID=? AND IN_REF=?");
				typeList.add(Types.VARCHAR);
				objList.add(sourceId);
				typeList.add(Types.VARCHAR);
				objList.add("0");
			}else if("1".equals(inRef)) {
				//有关系数据-市
				sql.append("   SELECT * FROM (");
				sql.append(" SELECT AA.*,AA.METERIAL_NUM_BALANCE+BB.METERIAL_NUM REAL_METERIAL_NUM_TOTAL,AA.METERIAL_ACCOUNT_BALANCE+BB.METERIAL_ACCOUNT REAL_METERIAL_ACCOUNT_TOTAL,");
				sql.append(" BB.METERIAL_NUM REAL_METERIAL_NUM,BB.METERIAL_ACCOUNT REAL_METERIAL_ACCOUNT ");
				sql.append(" FROM ");
				sql.append(" (SELECT F.* FROM DIS_FUNDS_SOURCE_DETAIL F WHERE F.SOURCE_ID=? AND F.FUNDS_TYPE=?) AA");
				sql.append(" JOIN (SELECT FS.* FROM DIS_FUNDS_SOURCE_DETAIL FS WHERE FS.SOURCE_ID=? AND FS.IN_REF=?) BB");
				sql.append(" ON AA.ALLOCATION_DETAIL_ID=BB.OLD_ALLOCATION_DETAIL_ID");
				typeList.add(Types.VARCHAR);
				objList.add(sourceId);
				typeList.add(Types.VARCHAR);
				objList.add(fundsType);
				typeList.add(Types.VARCHAR);
				objList.add(currentSourceId);
				typeList.add(Types.VARCHAR);
				objList.add("1");
				
				sql.append(" UNION");
				sql.append(" SELECT F.*,F.METERIAL_NUM_BALANCE REAL_METERIAL_NUM_TOTAL,F.METERIAL_ACCOUNT_BALANCE REAL_METERIAL_ACCOUNT_TOTAL,0.0 REAL_METERIAL_NUM,0.0 REAL_METERIAL_ACCOUNT");
				sql.append(" FROM DIS_FUNDS_SOURCE_DETAIL F WHERE F.SOURCE_ID=? AND F.FUNDS_TYPE=?");
				sql.append(" AND F.ALLOCATION_DETAIL_ID NOT IN (");
				sql.append(" SELECT FS.OLD_ALLOCATION_DETAIL_ID FROM DIS_FUNDS_SOURCE_DETAIL FS WHERE FS.SOURCE_ID=? AND FS.IN_REF=?)");
				sql.append(" ) AAA ORDER BY AAA.REAL_METERIAL_ACCOUNT DESC,AAA.ALLOCATION_DETAIL_ID");
				typeList.add(Types.VARCHAR);
				objList.add(sourceId);
				typeList.add(Types.VARCHAR);
				objList.add(fundsType);
				typeList.add(Types.VARCHAR);
				objList.add(currentSourceId);
				typeList.add(Types.VARCHAR);
				objList.add("1");
			}
		}else if("13".equals(organType)) {
			//县级
			if("0".equals(inRef)) {
				//无关系数据-县
				sql.append("SELECT F.*,F.METERIAL_NUM_BALANCE REAL_METERIAL_NUM_TOTAL,F.METERIAL_ACCOUNT_BALANCE REAL_METERIAL_ACCOUNT_TOTAL,0.0 REAL_METERIAL_NUM,0.0 REAL_METERIAL_ACCOUNT");
				sql.append(" FROM DIS_FUNDS_SOURCE_DETAIL F WHERE SOURCE_ID=? AND IN_REF=?");
				typeList.add(Types.VARCHAR);
				objList.add(sourceId);
				typeList.add(Types.VARCHAR);
				if("2".equals(actionFundsType)) 
					objList.add("1"); //取市款---市往县拨付后，关系为1
				else if("3".equals(actionFundsType))
					objList.add("0");  //取县款
				else
					throw new RuntimeException("未知款项标志");
				
			}else if("1".equals(inRef)) {
				//有关系数据-县
				sql.append("   SELECT * FROM (");
				sql.append(" SELECT AA.*,AA.METERIAL_NUM_BALANCE+BB.METERIAL_NUM REAL_METERIAL_NUM_TOTAL,AA.METERIAL_ACCOUNT_BALANCE+BB.METERIAL_ACCOUNT REAL_METERIAL_ACCOUNT_TOTAL,");
				sql.append(" BB.METERIAL_NUM REAL_METERIAL_NUM,BB.METERIAL_ACCOUNT REAL_METERIAL_ACCOUNT ");
				sql.append(" FROM ");
				sql.append(" (SELECT F.* FROM DIS_FUNDS_SOURCE_DETAIL F WHERE F.SOURCE_ID=? AND F.FUNDS_TYPE=?) AA");
				sql.append(" JOIN (SELECT FS.* FROM DIS_FUNDS_SOURCE_DETAIL FS WHERE FS.SOURCE_ID=? AND FS.IN_REF=?) BB");
				sql.append(" ON AA.ALLOCATION_DETAIL_ID=BB.OLD_ALLOCATION_DETAIL_ID");
				typeList.add(Types.VARCHAR);
				objList.add(sourceId);
				typeList.add(Types.VARCHAR);
				objList.add(fundsType);
				typeList.add(Types.VARCHAR);
				objList.add(currentSourceId);
				typeList.add(Types.VARCHAR);
				objList.add("1");
				
				sql.append(" UNION ");
				sql.append(" SELECT F.*,F.METERIAL_NUM_BALANCE REAL_METERIAL_NUM_TOTAL,F.METERIAL_ACCOUNT_BALANCE REAL_METERIAL_ACCOUNT_TOTAL,0.0 REAL_METERIAL_NUM,0.0 REAL_METERIAL_ACCOUNT");
				sql.append(" FROM DIS_FUNDS_SOURCE_DETAIL F WHERE F.SOURCE_ID=? AND F.FUNDS_TYPE=?");
				sql.append(" AND F.ALLOCATION_DETAIL_ID NOT IN (");
				sql.append(" SELECT FS.OLD_ALLOCATION_DETAIL_ID FROM DIS_FUNDS_SOURCE_DETAIL FS WHERE FS.SOURCE_ID=? AND FS.IN_REF=?)");
				sql.append(" ) AAA ORDER BY AAA.REAL_METERIAL_ACCOUNT DESC,AAA.ALLOCATION_DETAIL_ID");
				typeList.add(Types.VARCHAR);
				objList.add(sourceId);
				typeList.add(Types.VARCHAR);
				objList.add(fundsType);
				typeList.add(Types.VARCHAR);
				objList.add(currentSourceId);
				typeList.add(Types.VARCHAR);
				objList.add("1");
			}
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
					ds.addRecord(getDisFundsSourceDetail(tempDs.getRecord(i)));
				}
			}
		}
		return ds;
	}

	//record转bean
	public DisFundsSourceDetail getDisFundsSourceDetail(Record record) {
		DisFundsSourceDetail dataBean = new DisFundsSourceDetail();
		dataBean.setAllocationDetailId((String) record.get("ALLOCATION_DETAIL_ID"));
		dataBean.setSourceId((String) record.get("SOURCE_ID"));
		dataBean.setBatchId((String) record.get("BATCH_ID"));
		dataBean.setAllocationType((String) record.get("ALLOCATION_TYPE"));
		dataBean.setMeterialType((String) record.get("METERIAL_TYPE"));

		if(record.get("METERIAL_NUM") != null)
			dataBean.setMeterialNum(new BigDecimal(record.get("METERIAL_NUM").toString()));
		if(record.get("METERIAL_UNITPRICE") != null)
			dataBean.setMeterialNumBalance(new BigDecimal(record.get("METERIAL_UNITPRICE").toString()));

		dataBean.setMeterialUnit((String) record.get("METERIAL_UNIT"));
		if(record.get("METERIAL_ACCOUNT") != null)
			dataBean.setMeterialAccount(new BigDecimal(record.get("METERIAL_ACCOUNT").toString()));
		if(record.get("METERIAL_NUM_BALANCE") != null)
			dataBean.setMeterialNumBalance(new BigDecimal(record.get("METERIAL_NUM_BALANCE").toString()));
		if(record.get("METERIAL_ACCOUNT_BALANCE") != null)
			dataBean.setMeterialAccountBalance(new BigDecimal(record.get("METERIAL_ACCOUNT_BALANCE").toString()));

		dataBean.setFundsType((String) record.get("FUNDS_TYPE"));
		dataBean.setInRef((String) record.get("IN_REF"));
		dataBean.setInUse((String) record.get("IN_USE"));
		dataBean.setOldAllocationDetailId((String) record.get("OLD_ALLOCATION_DETAIL_ID"));
		dataBean.setOldAllocationDetail((String) record.get("OLD_ALLOCATION_DETAIL"));

		if(record.get("REAL_METERIAL_NUM") != null)
			dataBean.setRealMeterialNum(new BigDecimal(record.get("REAL_METERIAL_NUM").toString()));
		if(record.get("REAL_METERIAL_ACCOUNT") != null)
			dataBean.setRealMeterialAccount(new BigDecimal(record.get("REAL_METERIAL_ACCOUNT").toString()));
		if(record.get("REAL_METERIAL_NUM_TOTAL") != null)
			dataBean.setRealMeterialNumTotal(new BigDecimal(record.get("REAL_METERIAL_NUM_TOTAL").toString()));
		if(record.get("REAL_METERIAL_ACCOUNT_TOTAL") != null)
			dataBean.setRealMeterialAccountTotal(new BigDecimal(record.get("REAL_METERIAL_ACCOUNT_TOTAL").toString()));
		return dataBean;
	}
	
	/**
	 * @Description: 关系数据的物资返还给源编码-重置关系数据-根据源记录
	 * @author xuexzh
	 */
	public void resetRefByOld(Record[] oldDisFundsSourceDetailDs, DisFundsSource disFundsSource) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		//获取本明细所有的拨付关系
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT * FROM DIS_FUNDS_SOURCE_DETAIL WHERE SOURCE_ID=? AND IN_REF=? ");
		typeList.add(Types.VARCHAR);
		objList.add(disFundsSource.getSourceId());
		typeList.add(Types.VARCHAR);
		objList.add("1");

		sql.append(" AND OLD_ALLOCATION_DETAIL_ID IN(");
		for(int i=0;i<oldDisFundsSourceDetailDs.length; i++) {
			sql.append("?");
			typeList.add(Types.VARCHAR);
			objList.add((String)oldDisFundsSourceDetailDs[i].get("allocationDetailId"));
			if(i!=oldDisFundsSourceDetailDs.length-1){
				sql.append(",");
			}
		}
		sql.append(")");
		if(typeList.size()>0&&objList.size()>0){
			int[] types = new int[typeList.size()];
			for (int i = 0; i < types.length; i++) {
				types[i]=typeList.get(i);
			}
			Object[] objs = objList.toArray(new Object[objList.size()]);
			DataSet ds = this.executeDataset(sql.toString(), types, objs, true);
			if(ds.getCount()>0) {
				//逐个更新拨付关系对应的源明细的值（回加）
				String innerSql="UPDATE DIS_FUNDS_SOURCE_DETAIL SET METERIAL_NUM_BALANCE=METERIAL_NUM_BALANCE+?,METERIAL_ACCOUNT_BALANCE=METERIAL_ACCOUNT_BALANCE+? WHERE ALLOCATION_DETAIL_ID=?";
				int[] types2 = new int[3];
				types2[0] = Types.DECIMAL;
				types2[1] = Types.DECIMAL;
				types2[2] = Types.VARCHAR;
				Object[] args2 = new Object[3];
				args2[0] = 0;
				args2[1] = 0;
				args2[2] = "";

				typeList.clear();
				objList.clear();
				for(int i=0; i<ds.getCount(); i++) {
					Record record = ds.getRecord(i);
					args2[0] = new BigDecimal(record.get("METERIAL_NUM").toString());
					args2[1] = new BigDecimal(record.get("METERIAL_ACCOUNT").toString());
					String oaId = (String)record.get("OLD_ALLOCATION_DETAIL_ID");
					args2[2] = oaId;
					typeList.add(Types.VARCHAR);
					objList.add(oaId);
					executeUpdate(innerSql, types2, args2);
				}

				StringBuffer sqlEnd = new StringBuffer();
				//验证所有的源数据是否存在未拨付的情况（即资金=结余）
				sqlEnd.append("UPDATE DIS_FUNDS_SOURCE_DETAIL SET IN_USE='0' WHERE METERIAL_NUM=METERIAL_NUM_BALANCE AND METERIAL_ACCOUNT=METERIAL_ACCOUNT_BALANCE AND ALLOCATION_DETAIL_ID IN(");
				int[] typesEnd = new int[typeList.size()];
				for (int i = 0; i < typesEnd.length; i++) {
					typesEnd[i] = typeList.get(i);
					sqlEnd.append("?");
					if(i != typesEnd.length-1) {
						sqlEnd.append(",");
					}
				}
				sqlEnd.append(")");
				Object[] argsEnd = objList.toArray(new Object[objList.size()]);
				executeUpdate(sqlEnd.toString(), typesEnd, argsEnd);
			}
		}
	}
	
	/**
	 * @Description: 删除关系数据-至临时表-根据源数据
	 * @author xuexzh
	 */

	public void deleteRefByOld(Record[] oldDisFundsSourceDetailDs, DisFundsSource disFundsSource) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		StringBuffer sql2 = new StringBuffer();

		sql.append("INSERT INTO DIS_FUNDS_SOURCE_DETAIL_BAK SELECT * FROM DIS_FUNDS_SOURCE_DETAIL WHERE SOURCE_ID=? AND IN_REF=?");
		sql2.append("DELETE FROM DIS_FUNDS_SOURCE_DETAIL WHERE SOURCE_ID=? AND IN_REF=? ");
		typeList.add(Types.VARCHAR);
		objList.add(disFundsSource.getSourceId());
		typeList.add(Types.VARCHAR);
		objList.add("1");

		sql.append(" AND OLD_ALLOCATION_DETAIL_ID IN(");
		sql2.append(" AND OLD_ALLOCATION_DETAIL_ID IN(");
		for(int i=0;i<oldDisFundsSourceDetailDs.length; i++) {
			sql.append("?");
			sql2.append("?");
			typeList.add(Types.VARCHAR);
			objList.add((String)oldDisFundsSourceDetailDs[i].get("allocationDetailId"));
			if(i!=oldDisFundsSourceDetailDs.length-1){
				sql.append(",");
				sql2.append(",");
			}
		}
		sql.append(")");
		sql2.append(")");
		if(typeList.size()>0&&objList.size()>0){
			int[] types = new int[typeList.size()];
			for (int i = 0; i < types.length; i++) {
				types[i]=typeList.get(i);
			}
			Object[] objs = objList.toArray(new Object[objList.size()]);
			executeUpdate(sql.toString(), types, objs);
			executeUpdate(sql2.toString(), types, objs);
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
		sql.append("UPDATE DIS_FUNDS_SOURCE_DETAIL SET IN_USE=? WHERE BATCH_ID=?");
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
	}

	/**
	 * @Description: 删除批次
	 * @author xuexzh
	 */
	public void deleteAllocation(DisFundsSourceBatch disFundsSourceBatch) {
		//1. 重置本批次下所有明细的使用源的值-先查询，后逐个重置
		ParameterSet pset = new ParameterSet();
		pset.setParameter("BATCH_ID", disFundsSourceBatch.getBatchId());
		pset.setParameter("IN_REF", "1");
		DataSet ds= query(pset);
		if(ds.getCount() > 0) {
			String innerSql="UPDATE DIS_FUNDS_SOURCE_DETAIL SET METERIAL_NUM_BALANCE=METERIAL_NUM_BALANCE+?,METERIAL_ACCOUNT_BALANCE=METERIAL_ACCOUNT_BALANCE+? WHERE ALLOCATION_DETAIL_ID=?";
			int[] types2 = new int[3];
			types2[0] = Types.DECIMAL;
			types2[1] = Types.DECIMAL;
			types2[2] = Types.VARCHAR;
			Object[] args2 = new Object[3];
			args2[0] = 0;
			args2[1] = 0;
			args2[2] = "";
			for(int i=0; i<ds.getCount(); i++) {
				DisFundsSourceDetail tempDfs = (DisFundsSourceDetail)ds.getRecord(i).toBean(DisFundsSourceDetail.class);
				args2[0] = tempDfs.getMeterialNum();
				args2[1] = tempDfs.getMeterialAccount();
				args2[2] = tempDfs.getOldAllocationDetailId();
				executeUpdate(innerSql, types2, args2);
			}
		}
		
		//2. 删除所有的明细及关系
		String sql = "DELETE DIS_FUNDS_SOURCE_DETAIL WHERE BATCH_ID=?";
		int[] types3 = new int[1];
		types3[0] = Types.VARCHAR;
		Object[] args3 = new Object[1];
		args3[0] = disFundsSourceBatch.getBatchId();

		this.executeUpdate(sql.toString(), types3, args3);
	}
}