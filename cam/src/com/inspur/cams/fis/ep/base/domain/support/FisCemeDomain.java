package com.inspur.cams.fis.ep.base.domain.support;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.Record;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.fis.ep.base.cmd.FisCemeCheckResultQueryCommand;
import com.inspur.cams.fis.ep.base.cmd.FisCemeCmd;
import com.inspur.cams.fis.ep.base.dao.IFisCemeDao;
import com.inspur.cams.fis.ep.base.dao.IFisCemeGovApprovalDao;
import com.inspur.cams.fis.ep.base.dao.IFisCemeItemsDao;
import com.inspur.cams.fis.ep.base.dao.IFisCemeLandcardDao;
import com.inspur.cams.fis.ep.base.data.FisCeme;
import com.inspur.cams.fis.ep.base.domain.IFisCemeDomain;

/**
 * @title: FisCemeDomain
 * @description:公墓信息行业库domain
 * @author:lidongdong
 * @since:2011-11-18
 * @version:1.0
 */
public class FisCemeDomain implements IFisCemeDomain {
	private IFisCemeDao fiscemeDao;
	private IFisCemeItemsDao fisCemeItemsDao;
	private IFisCemeGovApprovalDao fisCemeGovApprovalDao;
	private IFisCemeLandcardDao fisCemeLandcardDao;

	@Reference
	public void setFisCemeDao(IFisCemeDao fiscemeDao) {
		this.fiscemeDao = fiscemeDao;
	}

	@Reference
	public void setFisCemeItemsDao(IFisCemeItemsDao fisCemeItemsDao) {
		this.fisCemeItemsDao = fisCemeItemsDao;
	}

	@Reference
	public void setFisCemeGovApprovalDao(
			IFisCemeGovApprovalDao fisCemeGovApprovalDao) {
		this.fisCemeGovApprovalDao = fisCemeGovApprovalDao;
	}

	@Reference
	public void setFisCemeLandcardDao(IFisCemeLandcardDao fisCemeLandcardDao) {
		this.fisCemeLandcardDao = fisCemeLandcardDao;
	}

	public void save(List<FisCeme> list) {
		this.fiscemeDao.save(list);

	}

	public void delete(String[] delIds) {
		fiscemeDao.batchDelete(delIds);
	}

	public DataSet query(ParameterSet pset) {
		return fiscemeDao.query(pset);
	}

	public void insert(FisCeme dataBean) {
		fiscemeDao.insert(dataBean);
		fisCemeItemsDao.save(dataBean.getItemList());
		fisCemeGovApprovalDao.save(dataBean.getGovAppList());
		fisCemeLandcardDao.save(dataBean.getLandcardList());
	}

	public void update(FisCeme dataBean) {
		fiscemeDao.update(dataBean);
		fisCemeItemsDao.save(dataBean.getItemList());
		fisCemeGovApprovalDao.save(dataBean.getGovAppList());
		fisCemeLandcardDao.save(dataBean.getLandcardList());
	}

	// 获取当前单位下属公墓信息（带年检信息）
	public DataSet queryResult(ParameterSet pset) {
		return fiscemeDao.queryResult(pset);
	}

	public DataSet queryCemeBySql(ParameterSet pset) {
		return fiscemeDao.queryCemeBySql(pset);
	}

	public String queryGYPrint(ParameterSet pset) {
		StringBuffer str = new StringBuffer();
	
		DataSet ds4 = fiscemeDao.query(pset);
		Record record4 = ds4.getRecord(0);
		str.append(record4.get("fundSources")+ "%%");
		str.append(ifNull(record4.get("serviceScope"))+ "%%");
		
			DataSet ds = fisCemeGovApprovalDao.query(pset);
			if (ds.getCount() > 0) {
				for (int k = 0; k < ds.getCount(); k++) {
					Record record = ds.getRecord(k);
					String deptId = (String) record.get("deptId");
					String deptNum = (String) record.get("deptNum");
					String deptTime = (String) record.get("deptTime");

					str.append("文号类型：");
					str.append(getGovDept(deptId) + "，");
					str.append("批准文号：");
					str.append(deptNum + "，");
					str.append("批准时间：");
					str.append(ifNull(deptTime) + "；" + "\n");
				}
			}
		return str.toString();
	}
	
	public String queryPrint(ParameterSet pset) {
		StringBuffer str = new StringBuffer();
		
		DataSet ds4 = fiscemeDao.query(pset);
		Record record4 = ds4.getRecord(0);
		str.append(ifNull(record4.get("serviceScope"))+ "%%");
		
		DataSet ds = fisCemeItemsDao.query(pset);
		for (int i = 0; i < ds.getCount(); i++) {
			Record record = ds.getRecord(i);
			String itemId = (String) record.get("itemId");
			str.append(record.get("itemTime") + "   ");
			str.append(getItem(record.get("itemDic")) + "(");
			str.append(record.get("itemLabel") + ")" + "\n");

			pset.clear();
			pset.setParameter("ITEM_ID", itemId);
			DataSet ds1 = fisCemeLandcardDao.query(pset);

			if (ds1.getCount() > 0) {
				str.append("土地证信息：" + "\n");
				for (int j = 0; j < ds1.getCount(); j++) {
					Record record1 = ds1.getRecord(j);
					String landNum = (String) record1.get("landNum");
					String landUse = (String) record1.get("landUse");
					String landUseForm = (String) record1.get("landUseForm");
					String landProp = (String) record1.get("landProp");
					String useAge = (String) record1.get("useAge");

					str.append("土地证号：");
					str.append(landNum + "，");
					str.append("土地用途：");
					str.append(getUse(landUse) + "，");
					str.append("土地使用形式：");
					str.append(getUseForm(landUseForm) + "，");
					str.append("土地使用权人：");
					str.append(getProp(landProp) + "，");
					str.append("使用年限：");
					str.append(ifNull(useAge) + "；" + "\n");
				}
			}
			DataSet ds2 = fisCemeGovApprovalDao.query(pset);
			if (ds2.getCount() > 0) {
				str.append("政府部门批准文号：" + "\n");
				for (int k = 0; k < ds2.getCount(); k++) {
					Record record2 = ds2.getRecord(k);
					String deptId = (String) record2.get("deptId");
					String deptNum = (String) record2.get("deptNum");
					String deptTime = (String) record2.get("deptTime");

					str.append("文号类型：");
					str.append(getGovDept(deptId) + "，");
					str.append("批准文号：");
					str.append(deptNum + "，");
					str.append("批准时间：");
					str.append(ifNull(deptTime) + "；" + "\n");
				}
			}
		}
		return str.toString();
	}

	String getItem(Object prop) {
		if ("0".equals(prop)) {
			return "批准建设";
		} else if ("1".equals(prop)) {
			return "批准经营";
		} else if ("2".equals(prop)) {
			return "改变用途";
		} else if ("3".equals(prop)) {
			return "变更";
		} else if ("4".equals(prop)) {
			return "迁址";
		} else if ("5".equals(prop)) {
			return "注销";
		} else if ("6".equals(prop)) {
			return "关闭";
		}
		return "";
	}
	
	String getUse(Object prop) {
		if ("1".equals(prop)) {
			return "殡葬用地";
		} else if ("2".equals(prop)) {
			return "工业用地";
		} else if ("3".equals(prop)) {
			return "市政用地";
		} else if ("4".equals(prop)) {
			return "公墓用地";
		} else if ("5".equals(prop)) {
			return "其它";
		}
		return "";
	}

	String getUseForm(Object prop) {
		if ("1".equals(prop)) {
			return "划拨";
		} else if ("2".equals(prop)) {
			return "出让";
		}
		return "";
	}

	String getProp(Object prop) {
		if ("1".equals(prop)) {
			return "国有";
		} else if ("2".equals(prop)) {
			return "集体所有";
		} else if ("3".equals(prop)) {
			return "租赁";
		}
		return "";
	}

	String getGovDept(Object dept) {
		if ("0".equals(dept)) {
			return "民政部门批准建设";
		} else if ("1".equals(dept)) {
			return "民政部门批准经营";
		} else if ("2".equals(dept)) {
			return "国土部门";
		} else if ("3".equals(dept)) {
			return "工商部门";
		} else if ("4".equals(dept)) {
			return "人事部门";
		} else if ("5".equals(dept)) {
			return "规划部门";
		} else if ("6".equals(dept)) {
			return "林业部门";
		} else if ("7".equals(dept)) {
			return "环保部门";
		} else if ("8".equals(dept)) {
			return "水资源部门";
		} else if ("9".equals(dept)) {
			return "媒体公告合格证书";
		} else if ("10".equals(dept)) {
			return "住建部门";
		}
		return "";
	}
	
	public Object ifNull(Object value){
		Object result =null;
		if(value==null){
			result="";
		}else{
			result=value;
		}
		return result;
	}

	/**
	 * 查询公墓系统上报信息（公墓部署）
	 * @return
	 */
	public DataSet queryImportCemeInfo(ParameterSet pset) {
		return fiscemeDao.queryImportCemeInfo(pset);
	}

	/**
	 * @Description: 公墓树查询
	 * @author xuexzh
	 */
	public DataSet queryOrganByUnitId(ParameterSet pset) {
		return fiscemeDao.queryOrganByUnitId(pset);
	}
}