package com.inspur.cams.dis.base.dao.jdbc;

import java.math.BigDecimal;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.Record;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.dis.base.dao.IDisFundsSourceBatchDao;
import com.inspur.cams.dis.base.data.DisFundsSource;
import com.inspur.cams.dis.base.data.DisFundsSourceBatch;

/**
 * 资金拨付批次表dao
 * @author 
 * @date 2013-01-04
 */
public class DisFundsSourceBatchDao extends EntityDao<DisFundsSourceBatch> implements IDisFundsSourceBatchDao {
	
	@Override
	public Class<DisFundsSourceBatch> getEntityClass() {
		return DisFundsSourceBatch.class;
	}
	
	/**
	 * @Description: 重新计算批次信息
	 * @author xuexzh
	 */
	public void reCompute(DisFundsSourceBatch disFundsSourceBatch) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		
		if(StringUtils.isEmpty(disFundsSourceBatch.getBatchId())) {
			throw new RuntimeException("无批次编码！");
		}
		
		//获取批次明细和值
		sql.append("SELECT NVL(SUM(F.AMOUNT_TOTAL),0) AMOUNT_TOTAL,NVL(SUM(F.AMOUNT),0) AMOUNT,");
		sql.append(" NVL(SUM(F.METERIAL),0) METERIAL,NVL(SUM(F.AMOUNT_BALANCE),0) AMOUNT_BALANCE,");
		sql.append(" NVL(SUM(F.METERIAL_BALANCE),0) METERIAL_BALANCE,NVL(SUM(F.AMOUNT_TOTAL_CENTRAL),0) AMOUNT_TOTAL_CENTRAL,");
		sql.append(" NVL(SUM(F.AMOUNT_TOTAL_DEPARTMENT),0) AMOUNT_TOTAL_DEPARTMENT,NVL(SUM(F.AMOUNT_TOTAL_CITY),0) AMOUNT_TOTAL_CITY,");
		sql.append(" NVL(SUM(F.AMOUNT_CITY),0) AMOUNT_CITY,NVL(SUM(F.METERIAL_CITY),0) METERIAL_CITY,");
		sql.append(" NVL(SUM(F.AMOUNT_TOTAL_COUNTY),0) AMOUNT_TOTAL_COUNTY,NVL(SUM(F.AMOUNT_COUNTY),0) AMOUNT_COUNTY,");
		sql.append(" NVL(SUM(F.METERIAL_COUNTY),0) METERIAL_COUNTY");
		sql.append(" FROM DIS_FUNDS_SOURCE F ");
		sql.append(" WHERE F.BATCH_ID=? AND F.IN_REF=?");
		typeList.add(Types.VARCHAR);
		objList.add(disFundsSourceBatch.getBatchId());
		typeList.add(Types.VARCHAR);
		objList.add("0");
		
		if(typeList.size()>0&&objList.size()>0){
			int[] types = new int[typeList.size()];
			for (int i = 0; i < types.length; i++) {
				types[i]=typeList.get(i);
			}
			Object[] objs = objList.toArray(new Object[objList.size()]);
			DataSet tempDs = this.executeDataset(sql.toString(), types, objs, true);
			if(tempDs.getCount()==1) {
				//单独更新批次每个字段
				Record record = tempDs.getRecord(0);
				sql.delete(0, sql.length());
				sql.append("UPDATE DIS_FUNDS_SOURCE_BATCH SET AMOUNT_TOTAL=?,AMOUNT=?,METERIAL=?,AMOUNT_BALANCE=?,METERIAL_BALANCE=?,");
				sql.append(" AMOUNT_TOTAL_CENTRAL=?,AMOUNT_TOTAL_DEPARTMENT=?,AMOUNT_TOTAL_CITY=?,AMOUNT_CITY=?,METERIAL_CITY=?,");
				sql.append(" AMOUNT_TOTAL_COUNTY=?,AMOUNT_COUNTY=?,METERIAL_COUNTY=?,FILL_ORGAN_CODE=?,FILL_ORGAN_NAME=?,");
				sql.append(" UPDATE_PEOPLE_NAME=?,UPDATE_TIME=? WHERE BATCH_ID=?");
				
				typeList.clear();
				objList.clear();

				typeList.add(Types.VARCHAR);
				objList.add(new BigDecimal(record.get("AMOUNT_TOTAL").toString()));
				typeList.add(Types.VARCHAR);
				objList.add(new BigDecimal(record.get("AMOUNT").toString()));
				typeList.add(Types.VARCHAR);
				objList.add(new BigDecimal(record.get("METERIAL").toString()));
				typeList.add(Types.VARCHAR);
				objList.add(new BigDecimal(record.get("AMOUNT_BALANCE").toString()));
				typeList.add(Types.VARCHAR);
				objList.add(new BigDecimal(record.get("METERIAL_BALANCE").toString()));
				
				typeList.add(Types.VARCHAR);
				objList.add(new BigDecimal(record.get("AMOUNT_TOTAL_CENTRAL").toString()));
				typeList.add(Types.VARCHAR);
				objList.add(new BigDecimal(record.get("AMOUNT_TOTAL_DEPARTMENT").toString()));
				typeList.add(Types.VARCHAR);
				objList.add(new BigDecimal(record.get("AMOUNT_TOTAL_CITY").toString()));
				typeList.add(Types.VARCHAR);
				objList.add(new BigDecimal(record.get("AMOUNT_CITY").toString()));
				typeList.add(Types.VARCHAR);
				objList.add(new BigDecimal(record.get("METERIAL_CITY").toString()));

				typeList.add(Types.VARCHAR);
				objList.add(new BigDecimal(record.get("AMOUNT_TOTAL_COUNTY").toString()));
				typeList.add(Types.VARCHAR);
				objList.add(new BigDecimal(record.get("AMOUNT_COUNTY").toString()));
				typeList.add(Types.VARCHAR);
				objList.add(new BigDecimal(record.get("METERIAL_COUNTY").toString()));
				typeList.add(Types.VARCHAR);
				objList.add(disFundsSourceBatch.getFillOrganCode());
				typeList.add(Types.VARCHAR);
				objList.add(disFundsSourceBatch.getFillOrganName());

				typeList.add(Types.VARCHAR);
				objList.add(disFundsSourceBatch.getUpdatePeopleName());
				typeList.add(Types.VARCHAR);
				objList.add(disFundsSourceBatch.getUpdateTime());
				typeList.add(Types.VARCHAR);
				objList.add(disFundsSourceBatch.getBatchId());
				
				int[] types2 = new int[typeList.size()];
				for (int i = 0; i < types2.length; i++) {
					types2[i]=typeList.get(i);
				}
				Object[] objs2 = objList.toArray(new Object[objList.size()]);
				this.executeUpdate(sql.toString(), types2, objs2);
			}else {
				throw new RuntimeException("批次无明细信息");
			}
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
		sql.append("UPDATE DIS_FUNDS_SOURCE_BATCH SET CONFIRM_PEOPLE_NAME=?,CONFIRM_TIME=?,IN_CONFIRM=? WHERE BATCH_ID=?");
		typeList.add(Types.VARCHAR);
		objList.add(disFundsSourceBatch.getConfirmPeopleName());
		typeList.add(Types.VARCHAR);
		objList.add(disFundsSourceBatch.getConfirmTime());
		typeList.add(Types.VARCHAR);
		objList.add(disFundsSourceBatch.getInConfirm());
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
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		sql.append("DELETE DIS_FUNDS_SOURCE_BATCH WHERE BATCH_ID=?");
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
	 * @Description: 验证数据
	 * @author xuexzh
	 */
	public void validateData(DisFundsSourceBatch disFundsSourceBatch) {
		String organType = BspUtil.getOrganType();
		try {
			BigDecimal zero = new BigDecimal(0.0);
			
			int[] types2 = new int[2];
			Object[] args2 = new Object[2];
			types2[0] = Types.VARCHAR;
			types2[1] = Types.VARCHAR;
			args2[0] = disFundsSourceBatch.getBatchId();
			args2[1] = "0";
			
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT * FROM DIS_FUNDS_SOURCE WHERE BATCH_ID=? AND IN_REF=?");
			DataSet mainDs = this.executeDataset(sql.toString(), types2, args2, true);
			if(mainDs.getCount()>0) {
				//验证主数据
				for(int i=0;i<mainDs.getCount();i++) {
					DisFundsSource disFundsSource = getDisFundsSource(mainDs.getRecord(i));
					if(StringUtils.isEmpty(disFundsSource.getBatchId()))
						debugInfo("主记录出错：批次为空！"+disFundsSource.getSourceId());
					if(StringUtils.isEmpty(disFundsSource.getSourceType()))
						debugInfo("主记录出错：资金来源类型为空！"+disFundsSource.getSourceId());
					if(StringUtils.isEmpty(disFundsSource.getFundsType()))
						debugInfo("主记录出错：资金标识为空！"+disFundsSource.getSourceId());
					if(StringUtils.isEmpty(disFundsSource.getInRef()))
						debugInfo("主记录出错：关系标志为空！"+disFundsSource.getSourceId());
					if(StringUtils.isEmpty(disFundsSource.getInUse()))
						debugInfo("主记录出错：是否使用为空！"+disFundsSource.getSourceId());
					if(StringUtils.isEmpty(disFundsSource.getFillOrganCode()))
						debugInfo("主记录出错：填报单位区划为空！"+disFundsSource.getSourceId());
					if(StringUtils.isEmpty(disFundsSource.getFillOrganName()))
						debugInfo("主记录出错：填报单位名称为空！"+disFundsSource.getSourceId());
					if(StringUtils.isEmpty(disFundsSource.getReceiveOrganName()))
						debugInfo("主记录出错：接收单位名称为空！"+disFundsSource.getSourceId());
					if(StringUtils.isEmpty(disFundsSource.getReceiveOrganCode()))
						debugInfo("主记录出错：接收单位区划为空！"+disFundsSource.getSourceId());
	
					if(StringUtils.isNotEmpty(disFundsSource.getOldSourceId()))
						debugInfo("主记录出错：源编码不为空！"+disFundsSource.getSourceId());
					if(StringUtils.isNotEmpty(disFundsSource.getEndSourceId()))
						debugInfo("主记录出错：目的编码不为空！"+disFundsSource.getSourceId());
					if(StringUtils.isNotEmpty(disFundsSource.getOldFundsType()))
						debugInfo("主记录出错：源资金标识不为空！"+disFundsSource.getSourceId());
					
					if(disFundsSource.getAmountTotal() == null)
						debugInfo("主记录出错：拨款总额为空！"+disFundsSource.getSourceId());
					if(disFundsSource.getAmount() == null)
						debugInfo("主记录出错：拨款资金金额为空！"+disFundsSource.getSourceId());
					if(disFundsSource.getMeterial() == null)
						debugInfo("主记录出错：拨款物资金额为空！"+disFundsSource.getSourceId());
					if(disFundsSource.getAmountBalance() == null)
						debugInfo("主记录出错：拨款资金金额结余为空！"+disFundsSource.getSourceId());
					if(disFundsSource.getMeterialBalance() == null)
						debugInfo("主记录出错：拨款物资金额结余为空！"+disFundsSource.getSourceId());
					
					if(disFundsSource.getAmountTotalCentral()==null)
						disFundsSource.setAmountTotalCentral(zero);
					if(disFundsSource.getAmountTotalDepartment()==null)
						disFundsSource.setAmountTotalDepartment(zero);
					if(disFundsSource.getAmountTotalCity()==null)
						disFundsSource.setAmountTotalCity(zero);
					if(disFundsSource.getAmountCity()==null)
						disFundsSource.setAmountCity(zero);
					if(disFundsSource.getMeterialCity()==null)
						disFundsSource.setMeterialCity(zero);
					if(disFundsSource.getAmountTotalCounty()==null)
						disFundsSource.setAmountTotalCounty(zero);
					if(disFundsSource.getAmountCounty()==null)
						disFundsSource.setAmountCounty(zero);
					if(disFundsSource.getMeterialCounty()==null)
						disFundsSource.setMeterialCounty(zero);

					if(disFundsSource.getAmountTotal().compareTo(disFundsSource.getAmount().add(disFundsSource.getMeterial())) != 0) 
						debugInfo("主记录出错：拨款总额!=拨款资金金额+拨款物资金额！"+disFundsSource.getSourceId());
					if(disFundsSource.getAmountTotalCity().compareTo(disFundsSource.getAmountCity().add(disFundsSource.getMeterialCity())) != 0) 
						debugInfo("主记录出错：市拨款总额!=市拨款资金金额+市拨款物资金额！"+disFundsSource.getSourceId());
					if(disFundsSource.getAmountTotalCounty().compareTo(disFundsSource.getAmountCounty().add(disFundsSource.getMeterialCounty())) != 0) 
						debugInfo("主记录出错：县拨款总额!=县拨款资金金额+县拨款物资金额！"+disFundsSource.getSourceId());
					
					BigDecimal a = disFundsSource.getAmountTotalCentral().add(disFundsSource.getAmountTotalDepartment());
					a = a.add(disFundsSource.getAmountCity());
					a = a.add(disFundsSource.getAmountCounty());
					BigDecimal m = disFundsSource.getMeterialCity().add(disFundsSource.getMeterialCounty());
					if(disFundsSource.getAmount().compareTo(a) != 0) 
						debugInfo("主记录出错：拨款资金金额!=各级拨款资金金额之和！"+disFundsSource.getSourceId());
					if(disFundsSource.getMeterial().compareTo(m) != 0) 
						debugInfo("主记录出错：拨款物资金额!=各级拨款物资金额之和！"+disFundsSource.getSourceId());
				}
			}
			args2[1]="1";
			DataSet refDs = this.executeDataset(sql.toString(), types2, args2, true);
			if(refDs.getCount()>0) {
				//验证关系数据
				for(int i=0;i<refDs.getCount();i++) {
					DisFundsSource disFundsSource = getDisFundsSource(refDs.getRecord(i));
					if(StringUtils.isEmpty(disFundsSource.getBatchId()))
						debugInfo("关系记录出错：批次为空！"+disFundsSource.getSourceId());
					if(StringUtils.isEmpty(disFundsSource.getSourceType()))
						debugInfo("关系记录出错：资金来源类型为空！"+disFundsSource.getSourceId());
					if(StringUtils.isEmpty(disFundsSource.getFundsType()))
						debugInfo("关系记录出错：资金标识为空！"+disFundsSource.getSourceId());
					if(StringUtils.isEmpty(disFundsSource.getInRef()))
						debugInfo("关系记录出错：关系标志为空！"+disFundsSource.getSourceId());
					if(StringUtils.isEmpty(disFundsSource.getInUse()))
						debugInfo("关系记录出错：是否使用为空！"+disFundsSource.getSourceId());
					if(StringUtils.isEmpty(disFundsSource.getFillOrganCode()))
						debugInfo("关系记录出错：填报单位区划为空！"+disFundsSource.getSourceId());
					if(StringUtils.isEmpty(disFundsSource.getFillOrganName()))
						debugInfo("关系记录出错：填报单位名称为空！"+disFundsSource.getSourceId());
					if(StringUtils.isEmpty(disFundsSource.getReceiveOrganName()))
						debugInfo("关系记录出错：接收单位名称为空！"+disFundsSource.getSourceId());
					if(StringUtils.isEmpty(disFundsSource.getReceiveOrganCode()))
						debugInfo("关系记录出错：接收单位区划为空！"+disFundsSource.getSourceId());
	
					if(StringUtils.isEmpty(disFundsSource.getOldSourceId()))
						debugInfo("关系记录出错：源编码为空！"+disFundsSource.getSourceId());
					if(StringUtils.isEmpty(disFundsSource.getEndSourceId()))
						debugInfo("关系记录出错：目的编码为空！"+disFundsSource.getSourceId());
//					if(StringUtils.isEmpty(disFundsSource.getOldUpAllocationNum()))
//						debugInfo("关系记录出错：源文号为空！"+disFundsSource.getSourceId());
					if(StringUtils.isEmpty(disFundsSource.getOldFundsType()))
						debugInfo("关系记录出错：源资金标识为空！"+disFundsSource.getSourceId());
					if(disFundsSource.getFundsType().equals(disFundsSource.getOldFundsType()))
						debugInfo("关系记录出错：源资金标识==资金标识！"+disFundsSource.getSourceId());
						
					if("12".equals(organType)) {
						//市级需要多验证中间数据
						if("0".equals(disFundsSource.getOldFundsType()) || "1".equals(disFundsSource.getOldFundsType())) {
							//中央款或省级款需验证中间数据
							if(StringUtils.isEmpty(disFundsSource.getMidUpAllocationNum()))
								debugInfo("关系记录出错：中间文号为空！"+disFundsSource.getSourceId());
							if(StringUtils.isEmpty(disFundsSource.getMidUpAllocationNumNext()))
								debugInfo("关系记录出错：中间记录信息为空！"+disFundsSource.getSourceId());
						}
					}
					
					if(disFundsSource.getAmountTotal() == null)
						debugInfo("关系记录出错：拨款总额为空！"+disFundsSource.getSourceId());
					if(disFundsSource.getAmount() == null)
						debugInfo("关系记录出错：拨款资金金额为空！"+disFundsSource.getSourceId());
					if(disFundsSource.getMeterial() == null)
						debugInfo("关系记录出错：拨款物资金额为空！"+disFundsSource.getSourceId());
					if(disFundsSource.getAmountBalance() == null)
						debugInfo("关系记录出错：拨款资金金额结余为空！"+disFundsSource.getSourceId());
					if(disFundsSource.getMeterialBalance() == null)
						debugInfo("关系记录出错：拨款物资金额结余为空！"+disFundsSource.getSourceId());
					

					if(disFundsSource.getAmountTotalCentral()!=null && disFundsSource.getAmountTotalCentral().compareTo(zero) > 0) 
						debugInfo("关系记录出错：中央拨款资金金额大于零！"+disFundsSource.getSourceId());
					if(disFundsSource.getAmountTotalDepartment()!=null && disFundsSource.getAmountTotalDepartment().compareTo(zero) > 0) 
						debugInfo("关系记录出错：省拨款资金金额大于零！"+disFundsSource.getSourceId());

					if(disFundsSource.getAmountTotalCity()!=null && disFundsSource.getAmountTotalCity().compareTo(zero) > 0) 
						debugInfo("关系记录出错：市拨款总额大于零！"+disFundsSource.getSourceId());
					if(disFundsSource.getAmountCity()!=null && disFundsSource.getAmountCity().compareTo(zero) > 0) 
						debugInfo("关系记录出错：市拨款资金金额大于零！"+disFundsSource.getSourceId());
					if(disFundsSource.getMeterialCity()!=null && disFundsSource.getMeterialCity().compareTo(zero) > 0) 
						debugInfo("关系记录出错：市拨款物资金额大于零！"+disFundsSource.getSourceId());

					if(disFundsSource.getAmountTotalCounty()!=null && disFundsSource.getAmountTotalCounty().compareTo(zero) > 0) 
						debugInfo("关系记录出错：县拨款总额大于零！"+disFundsSource.getSourceId());
					if(disFundsSource.getAmountCounty()!=null && disFundsSource.getAmountCounty().compareTo(zero) > 0) 
						debugInfo("关系记录出错：县拨款资金金额大于零！"+disFundsSource.getSourceId());
					if(disFundsSource.getMeterialCounty()!=null && disFundsSource.getMeterialCounty().compareTo(zero) > 0) 
						debugInfo("关系记录出错：县拨款物资金额大于零！"+disFundsSource.getSourceId());
						

					if(disFundsSource.getAmountTotal().compareTo(disFundsSource.getAmount().add(disFundsSource.getMeterial())) != 0) 
						debugInfo("关系记录出错：拨款总额!=拨款资金金额+拨款物资金额！"+disFundsSource.getSourceId());
					if(disFundsSource.getAmountTotal().compareTo(disFundsSource.getAmountBalance().add(disFundsSource.getMeterialBalance())) != 0) 
						debugInfo("关系记录出错：拨款总额!=拨款资金金额结余+拨款物资金额结余！"+disFundsSource.getSourceId());
				}
			}
			
			//主数据与关系数据的联合验证
			if(mainDs.getCount()>0) {
				//验证主表主记录的款==关系记录的款之和
				sql.delete(0, sql.length());
				sql.append("SELECT NVL(SUM(AMOUNT),0) AMOUNT,NVL(SUM(METERIAL),0) METERIAL FROM DIS_FUNDS_SOURCE WHERE END_SOURCE_ID=? AND IN_REF=? AND OLD_FUNDS_TYPE=?");
				int[] types3 = new int[3];
				Object[] args3 = new Object[3];
				types3[0] = Types.VARCHAR;
				types3[1] = Types.VARCHAR;
				types3[2] = Types.VARCHAR;
				args3[1] = "1";
				//验证主表物资金额==明细总和
				StringBuffer sql2 = new StringBuffer();
				sql2.append("SELECT NVL(SUM(METERIAL_ACCOUNT),0) METERIAL_ACCOUNT FROM DIS_FUNDS_SOURCE_DETAIL WHERE SOURCE_ID=? AND IN_REF=?");
				args2[1] = "1";
				
				//验证主表物资金额==明细总和(分市级/县级)
				StringBuffer sql3 = new StringBuffer();
				sql3.append("SELECT NVL(SUM(METERIAL_ACCOUNT),0) METERIAL_ACCOUNT FROM DIS_FUNDS_SOURCE_DETAIL WHERE SOURCE_ID=? AND IN_REF=? AND FUNDS_TYPE=?");
				int[] types31 = new int[3];
				Object[] args31 = new Object[3];
				types31[0] = Types.VARCHAR;
				types31[1] = Types.VARCHAR;
				types31[2] = Types.VARCHAR;
				args31[1] = "1";
				
				for(int i=0;i<mainDs.getCount();i++) {
					DisFundsSource disFundsSource = getDisFundsSource(mainDs.getRecord(i));
					args2[0] = disFundsSource.getSourceId();
					args3[0] = disFundsSource.getSourceId();
					args31[0] = disFundsSource.getSourceId();
					DataSet tempDs;
					BigDecimal amountSums = new BigDecimal(0.0);
					BigDecimal meterialSums = new BigDecimal(0.0);
					if(disFundsSource.getAmountTotalCentral().compareTo(zero) > 0) {
						//有中央款
						args3[2] = "0";
						amountSums = new BigDecimal(0.0);
						tempDs = this.executeDataset(sql.toString(), types3, args3, true);
						if(tempDs.getCount()>0) {
							for(int j=0;j<tempDs.getCount();j++) {
								amountSums = amountSums.add((BigDecimal)(tempDs.getRecord(j).get("AMOUNT")));
							}
							
							if(disFundsSource.getAmountTotalCentral().compareTo(amountSums) != 0)
								debugInfo("联合验证出错：中央款!=下属关系款之和！"+disFundsSource.getSourceId());
						}else {
							debugInfo("联合验证出错：中央款无下属关系！"+disFundsSource.getSourceId());
						}
					}
					if(disFundsSource.getAmountTotalDepartment().compareTo(zero) > 0) {
						//有省级款
						args3[2] = "1";
						amountSums = new BigDecimal(0.0);
						tempDs = this.executeDataset(sql.toString(), types3, args3, true);
						if(tempDs.getCount()>0) {
							for(int j=0;j<tempDs.getCount();j++) {
								amountSums = amountSums.add((BigDecimal)(tempDs.getRecord(j).get("AMOUNT")));
							}
							
							if(disFundsSource.getAmountTotalDepartment().compareTo(amountSums) != 0)
								debugInfo("联合验证出错：省级款!=下属关系款之和！"+disFundsSource.getSourceId());
						}else {
							debugInfo("联合验证出错：省级款无下属关系！"+disFundsSource.getSourceId());
						}
					}
					if(disFundsSource.getAmountTotalCity().compareTo(zero) > 0) {
						//有市级款
						args3[2] = "2";
						amountSums = new BigDecimal(0.0);
						meterialSums = new BigDecimal(0.0);
						tempDs = this.executeDataset(sql.toString(), types3, args3, true);
						if(tempDs.getCount()>0) {
							for(int j=0;j<tempDs.getCount();j++) {
								amountSums = amountSums.add((BigDecimal)(tempDs.getRecord(j).get("AMOUNT")));
								meterialSums = meterialSums.add((BigDecimal)(tempDs.getRecord(j).get("METERIAL")));
							}
							
							if(disFundsSource.getAmountCity().compareTo(amountSums) != 0)
								debugInfo("联合验证出错：市级资金!=下属关系资金之和！"+disFundsSource.getSourceId());
							if(disFundsSource.getMeterialCity().compareTo(meterialSums) != 0)
								debugInfo("联合验证出错：市级物资!=下属关系物资之和！"+disFundsSource.getSourceId());
						}else {
							debugInfo("联合验证出错：市级款无下属关系！"+disFundsSource.getSourceId());
						}
					}
					if(disFundsSource.getAmountTotalCounty().compareTo(zero) > 0) {
						//有县级款
						args3[2] = "3";
						amountSums = new BigDecimal(0.0);
						meterialSums = new BigDecimal(0.0);
						tempDs = this.executeDataset(sql.toString(), types3, args3, true);
						if(tempDs.getCount()>0) {
							for(int j=0;j<tempDs.getCount();j++) {
								amountSums = amountSums.add((BigDecimal)(tempDs.getRecord(j).get("AMOUNT")));
								meterialSums = meterialSums.add((BigDecimal)(tempDs.getRecord(j).get("METERIAL")));
							}
							
							if(disFundsSource.getAmountCounty().compareTo(amountSums) != 0)
								debugInfo("联合验证出错：县级资金!=下属关系资金之和！"+disFundsSource.getSourceId());
							if(disFundsSource.getMeterialCounty().compareTo(meterialSums) != 0)
								debugInfo("联合验证出错：县级物资!=下属关系物资之和！"+disFundsSource.getSourceId());
						}else {
							debugInfo("联合验证出错：县级款无下属关系！"+disFundsSource.getSourceId());
						}
					}
					if(disFundsSource.getMeterial().compareTo(zero) > 0) {
						//有明细的-总
						meterialSums = new BigDecimal(0.0);
						tempDs = this.executeDataset(sql2.toString(), types2, args2, true);
						if(tempDs.getCount()>0) {
							for(int j=0;j<tempDs.getCount();j++) {
								meterialSums = meterialSums.add((BigDecimal)(tempDs.getRecord(j).get("METERIAL_ACCOUNT")));
							}
							
							if(disFundsSource.getMeterial().compareTo(meterialSums) != 0)
								debugInfo("联合验证出错(含明细)：总物资!=明细物资之和！"+disFundsSource.getSourceId());
						}else {
							debugInfo("联合验证出错(含明细)：总物资无明细！"+disFundsSource.getSourceId());
						}
					}
					if(disFundsSource.getMeterialCity().compareTo(zero) > 0) {
						//有市级明细的
						args31[2] = "3";
						meterialSums = new BigDecimal(0.0);
						tempDs = this.executeDataset(sql3.toString(), types31, args31, true);
						if(tempDs.getCount()>0) {
							for(int j=0;j<tempDs.getCount();j++) {
								meterialSums = meterialSums.add((BigDecimal)(tempDs.getRecord(j).get("METERIAL_ACCOUNT")));
							}
							
							if(disFundsSource.getMeterialCity().compareTo(meterialSums) != 0)
								debugInfo("联合验证出错(含明细)：市级物资!=明细物资之和！"+disFundsSource.getSourceId());
						}else {
							debugInfo("联合验证出错(含明细)：市级物资无明细！"+disFundsSource.getSourceId());
						}
					}
					if(disFundsSource.getMeterialCounty().compareTo(zero) > 0) {
						//有市级明细的
						args31[2] = "4";
						meterialSums = new BigDecimal(0.0);
						tempDs = this.executeDataset(sql3.toString(), types31, args31, true);
						if(tempDs.getCount()>0) {
							for(int j=0;j<tempDs.getCount();j++) {
								meterialSums = meterialSums.add((BigDecimal)(tempDs.getRecord(j).get("METERIAL_ACCOUNT")));
							}
							
							if(disFundsSource.getMeterialCounty().compareTo(meterialSums) != 0)
								debugInfo("联合验证出错(含明细)：县级物资!=明细物资之和！"+disFundsSource.getSourceId());
						}else {
							debugInfo("联合验证出错(含明细)：县级物资无明细！"+disFundsSource.getSourceId());
						}
					}
				}
			}
		}catch(Exception e) {
			e.getStackTrace();
			System.out.println(e.getMessage());
			throw new RuntimeException("验证数据出错:");
		}
	}
	
	private void debugInfo(String info) {
		System.out.println(info);
	}
	
	//record转bean
	public DisFundsSource getDisFundsSource(Record record) {
		DisFundsSource dataBean = new DisFundsSource();
		BigDecimal zero = new BigDecimal(0);
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
		else 
			dataBean.setAmountTotalCentral(zero);
		if(record.get("AMOUNT_TOTAL_DEPARTMENT") != null)
			dataBean.setAmountTotalDepartment(new BigDecimal(record.get("AMOUNT_TOTAL_DEPARTMENT").toString()));
		else 
			dataBean.setAmountTotalDepartment(zero);
		
		if(record.get("AMOUNT_TOTAL_CITY") != null)
			dataBean.setAmountTotalCity(new BigDecimal(record.get("AMOUNT_TOTAL_CITY").toString()));
		else 
			dataBean.setAmountTotalCity(zero);
		if(record.get("AMOUNT_CITY") != null)
			dataBean.setAmountCity(new BigDecimal(record.get("AMOUNT_CITY").toString()));
		else 
			dataBean.setAmountCity(zero);
		if(record.get("METERIAL_CITY") != null)
			dataBean.setMeterialCity(new BigDecimal(record.get("METERIAL_CITY").toString()));
		else 
			dataBean.setMeterialCity(zero);
		if(record.get("AMOUNT_TOTAL_COUNTY") != null)
			dataBean.setAmountTotalCounty(new BigDecimal(record.get("AMOUNT_TOTAL_COUNTY").toString()));
		else 
			dataBean.setAmountTotalCounty(zero);
		if(record.get("AMOUNT_COUNTY") != null)
			dataBean.setAmountCounty(new BigDecimal(record.get("AMOUNT_COUNTY").toString()));
		else 
			dataBean.setAmountCounty(zero);
		if(record.get("METERIAL_COUNTY") != null)
			dataBean.setMeterialCounty(new BigDecimal(record.get("METERIAL_COUNTY").toString()));
		else 
			dataBean.setMeterialCounty(zero);
		
		dataBean.setFundsType((String) record.get("FUNDS_TYPE"));
		dataBean.setInRef((String) record.get("IN_REF"));
		dataBean.setInUse((String) record.get("IN_USE"));
		
		dataBean.setOldFundsType((String) record.get("OLD_FUNDS_TYPE"));
		dataBean.setMidUpAllocationNum((String) record.get("MID_UP_ALLOCATION_NUM"));
		dataBean.setMidUpAllocationNumNext((String) record.get("MID_UP_ALLOCATION_NUM_NEXT"));
		return dataBean;
	}
}