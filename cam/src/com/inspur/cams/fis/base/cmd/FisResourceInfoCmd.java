package com.inspur.cams.fis.base.cmd;

import java.math.BigDecimal;
import org.apache.commons.lang.StringUtils;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.fis.base.data.FisResourceInfo;
import com.inspur.cams.fis.base.data.FisResourceLevel;
import com.inspur.cams.fis.base.data.FisResourceRule;
import com.inspur.cams.fis.base.data.FisResourceType;
import com.inspur.cams.fis.base.domain.IFisResourceInfoDomain;
import com.inspur.cams.fis.base.domain.IFisResourceLevelDomain;
import com.inspur.cams.fis.base.domain.IFisResourceRuleDomain;
import com.inspur.cams.fis.base.domain.IFisResourceTypeDomain;

/**
 * @Path com.inspur.cams.fis.base.cmd.FisResourceInfoCmd
 * @Description: TODO 殡葬业务资源Cmd
 * @author wangziming
 * @date 2011-11-15
 */
public class FisResourceInfoCmd extends BaseAjaxCommand {
	IFisResourceInfoDomain service = ScaComponentFactory.getService(IFisResourceInfoDomain.class, "FisResourceInfoDomain/FisResourceInfoDomain");
	IFisResourceTypeDomain typeService = ScaComponentFactory.getService(IFisResourceTypeDomain.class, "FisResourceTypeDomain/FisResourceTypeDomain");
	IFisResourceLevelDomain levelService = ScaComponentFactory.getService(IFisResourceLevelDomain.class, "FisResourceLevelDomain/FisResourceLevelDomain");
	IFisResourceRuleDomain ruleService = ScaComponentFactory.getService(IFisResourceRuleDomain.class, "FisResourceRuleDomain/FisResourceRuleDomain");

	public void insert() {
	}

	public void update() {
	}

	/**
	 * @author mq
	 */
	public void insertWithExtend() {
	}

	/**
	 * @author mq
	 */
	public void updateWithExtend() {
	}

	/**
	 * @author mq
	 */
	public void updateWithPrice() {
	}

	public void delete() {
	}

	/**
	 * 删除fisResourceInfo和FIS_RESOURCE_EXTEND数据
	 */
	public void deleteFisResourceInfoWithExtend() {
	}

	public void save() {
	}

	/**
	 * 获取根节点
	 */
	public void getRootData() {
		String resourceType = (String) getParameter("resourceType");
		String inUse = (String) getParameter("inUse");
		FisResourceType bean = new FisResourceType();
		if (StringUtils.isNotEmpty(resourceType)) {
			ParameterSet pset = new ParameterSet();
			pset.setParameter("RESOURCE_TYPE", resourceType);
			DataSet ds = typeService.query(pset);
			if (ds.getCount() != 0) {
				bean = (FisResourceType) ds.getRecord(0).toBean(FisResourceType.class);
			} else {
				throw new RuntimeException("资源分类已不存在！");
			}
			FisResourceInfo treeBean = new FisResourceInfo();
			treeBean.setResourceId(bean.getResourceType());
			treeBean.setResourceType(bean.getResourceType());
			treeBean.setResourceName(bean.getTypeName());
			treeBean.setResourceFullName("");
			Record rec = new Record();
			rec.fromBean(treeBean);
			setReturn("rootRecord", rec);
		}
	}

	/**
	 * 最后级别
	 */
	public void getLeafLevel() {
		ParameterSet pset = getParameterSet();
		DataSet ds = levelService.query(pset);
		FisResourceLevel bean = (FisResourceLevel) ds.getRecord(0).toBean(FisResourceLevel.class);
		setReturn("leafLevel", bean.getLevelId());
	}

	/**
	 * 倒数第二级别
	 */
	public void getTwiqLevel() {
		ParameterSet pset = getParameterSet();
		DataSet ds = levelService.query(pset);
		FisResourceLevel bean = new FisResourceLevel();
		String levelId = "";
		if (ds.getCount() == 1) {
			bean = (FisResourceLevel) ds.getRecord(0).toBean(FisResourceLevel.class);
		} else if (ds.getCount() > 1) {
			bean = (FisResourceLevel) ds.getRecord(1).toBean(FisResourceLevel.class);
			levelId = bean.getLevelId();
		}
		setReturn("twiqLevel", levelId);
	}

	/**
	 * 是否有子节点
	 */
	public void checkChild() {
		ParameterSet pset = getParameterSet();
		DataSet ds = service.query(pset);
		if (ds.getCount() == 0) {
			setReturn("hasChild", "NO");
		} else {
			setReturn("hasChild", "YES");
		}
	}

	/**
	 * 启用墓穴
	 * 
	 * @author mq
	 */
	public void checkChildEnableUse() {
		Record record = (Record) getParameter("record");
		if (record != null) {
			service.update((FisResourceInfo) record.toBean(FisResourceInfo.class));
		}
	}

	/**
	 * 停用墓穴
	 * 
	 * @author mq
	 */
	public void checkChildDisenableUse() {
		ParameterSet pset = getParameterSet();
		DataSet ds = service.checkChildDisenableUse(pset);
		String msg1 = new String();
		String msg2 = new String();
		String msg3 = new String();
		for (int i = 0; i < ds.getCount(); i++) {
			Record record = ds.getRecord(i);
			if (record.get("STATE").equals("A")) {
				msg1 = msg1 + record.get("NAME") + ",";
			}
			if (record.get("STATE").equals("B")) {
				msg2 = msg2 + record.get("NAME") + ",";
			}
			if (record.get("STATE").equals("C")) {
				msg3 = msg3 + record.get("NAME") + ",";
			}
		}
		String msg = "";
		if (msg1.length() > 0) {
			msg = msg + "留墓人员：" + msg1.substring(0, msg1.length() - 1) + ";";
		}
		if (msg2.length() > 0) {
			msg = msg + "定墓人员：" + msg2.substring(0, msg2.length() - 1) + ";";
		}
		if (msg3.length() > 0) {
			msg = msg + "安葬人员：" + msg3.substring(0, msg3.length() - 1) + ";";
		}
		setReturn("msg", msg);
	}

	public void getParentLevelId() {
		ParameterSet pset = getParameterSet();
		DataSet ds = service.query(pset);
		FisResourceInfo bean = (FisResourceInfo) ds.getRecord(0).toBean(FisResourceInfo.class);
		String parentResource = bean.getParentResource();
		pset.clear();
		pset.setParameter("RESOURCE_ID", parentResource);
		DataSet parentDs = service.query(pset);
		String parentLevelId = "";
		if (parentDs.getCount() > 0) {
			FisResourceInfo parentBean = (FisResourceInfo) parentDs.getRecord(0).toBean(FisResourceInfo.class);
			parentLevelId = parentBean.getResourceLevel();
		}
		setReturn("parentLevelId", parentLevelId);

	}

	/**
	 * 获取某一级别下允许的级别
	 */
	public void getSubLevelId() {
		String PARENT_LEVEL = (String) getParameter("PARENT_LEVEL");
		String resourceType = (String) getParameter("resourceType");
		StringBuffer subLevelId = new StringBuffer("");
		String strIds = "";
		ParameterSet pset = new ParameterSet();
		if (StringUtils.isNotEmpty(PARENT_LEVEL) && !PARENT_LEVEL.equals("undefined")) {
			pset.clear();
			pset.setParameter("PARENT_LEVEL", PARENT_LEVEL);
			DataSet ds = ruleService.query(pset);
			for (int i = 0; i < ds.getCount(); i++) {
				FisResourceRule bean = (FisResourceRule) ds.getRecord(i).toBean(FisResourceRule.class);
				subLevelId.append(bean.getChildrenLevel()).append(",");
			}
			strIds = subLevelId.substring(0, subLevelId.length() - 1).toString();
		} else {
			pset.clear();
			pset.setParameter("RESOURCE_TYPE", resourceType);
			pset.setParameter("LEVEL_NUM", "1");
			DataSet ds = levelService.query(pset);
			FisResourceLevel bean = (FisResourceLevel) ds.getRecord(0).toBean(FisResourceLevel.class);
			strIds = bean.getLevelId();
		}

		setReturn("subLevelId", strIds);
	}

	/**
	 * 获取排下号的个数
	 */
	public void getMaxNum() {
		ParameterSet pset = getParameterSet();
		BigDecimal dec = service.getLastLevelMaxNum(pset);
		setReturn("SUB_NUM", dec);
	}

	/**
	 * 接受并解析excel文件
	 */
	public void importExcel() {
	}

	/**
	 * 批量导入寄存设备数据
	 */
	@SuppressWarnings("unused")
	public void batchImportResourceInfo() {
	}

	/**
	 * 批量导入墓穴数据
	 * 
	 * @author mq
	 */
	public void batchImportResourceInfoWithExtend() {
	}

	/**
	 * 左端补零
	 * 
	 * @param num
	 * @param numeberWidth
	 * @return
	 */
	private String replaceNumToString(int num, int numeberWidth) {
		String result = "" + num;
		int bit = numeberWidth - ("" + num).length();
		for (int i = 0; i < bit; i++) {
			result = "0" + result;
		}
		return result;
	}

	/**
	 * @Title: beingLevelAndRule
	 * @Description: TODO(可分级的类别，是否定义级别和规则)
	 * @param
	 * @return void
	 * @throws
	 * @author jiangzhaobao
	 */
	public void beingLevelAndRule() {
		ParameterSet pset = getParameterSet();
		DataSet ds = service.beingLevelAndRule(pset);
		int num = ds.getCount();
		String isBeing = "0";
		if (num > 0) {
			isBeing = "1";
		}
		setReturn("isBeing", isBeing);
	}

	/**
	 * 接受并解析墓穴excel文件
	 * 
	 * @author mq
	 */
	public void importExcelOfCeme() {
	}
}