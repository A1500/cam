package com.inspur.cams.bpt.manage.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.data.BptCertTemplates;
import com.inspur.cams.bpt.base.domain.IBptCertTemplatesDomain;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * @title:BptCertTemplatesQueryCommand
 * @description:
 * @author:
 * @since:2011-11-22
 * @version:1.0
 */
public class BptCertTemplatesQueryCommand extends BaseQueryCommand {

	private IBptCertTemplatesDomain bptCertTemplatesDomain = ScaComponentFactory
			.getService(IBptCertTemplatesDomain.class,
					"BptCertTemplatesDomain/BptCertTemplatesDomain");

	private final static String DEPENTBG_DIR = "jsp/cams/bpt/peopleBasicInfo/table/dependantBG_apptable.doc"; // 三属病故模板默认路径

	private final static String DEPENTLS_DIR = "jsp/cams/bpt/peopleBasicInfo/table/dependantLS_apptable.doc"; // 三属烈士模板默认路径

	private final static String DEPENTYG_DIR = "jsp/cams/bpt/peopleBasicInfo/table/dependantYG_apptable.doc"; // 三属因公模板默认路径

	private final static String TEST_DIR = "jsp/cams/bpt/peopleBasicInfo/table/tested_apptable.doc"; // 参试模板默认路径

	private final static String WAR_DIR = "jsp/cams/bpt/peopleBasicInfo/table/war_apptable.doc"; // 参战模板默认路径

	private final static String DEMOBILIZED_DIR = "jsp/cams/bpt/peopleBasicInfo/table/demobilized_apptable.doc"; // 在乡复员模板默认路径

	private final static String DEMOBILIZEDILLNESS_DIR = "jsp/cams/bpt/peopleBasicInfo/table/demobilizedIllness_apptable.doc"; // 带病回乡模板默认路径

	
	private final static String DISABLILYGZ_DIR = "jsp/cams/bpt/peopleBasicInfo/table/disabilityGZ_apptable.doc"; //伤残国家机关工作人员
	
	private final static String DISABLILYJC_DIR = "jsp/cams/bpt/peopleBasicInfo/table/disabilityJC_apptable.doc"; //伤残人民警察
	
	private final static String DISABLILYJR_DIR = "jsp/cams/bpt/peopleBasicInfo/table/disabilityJR_apptable.doc"; //残疾军人
	
	private final static String DISABLILYMB_DIR = "jsp/cams/bpt/peopleBasicInfo/table/disabilityMB_apptable.doc"; //伤残民兵民工
	
	private final static String DISABILITYRP_DIR = "jsp/cams/bpt/flow/disability/exchacertidisa/print/disright.doc"; //伤残右变更
	
	private final static String DISABILITYLP_DIR = "jsp/cams/bpt/flow/disability/exchacertidisa/print/disleft.doc"; //伤残左变更
	
	private final static String DEMOBILIZEDIllNESSRP_DIR = "jsp/cams/bpt/flow/disability/exchacertidisa/print/demright.doc"; // 在乡复员右变更模板默认路径
	
	private final static String OTHERLP_DIR = "jsp/cams/bpt/flow/disability/exchacertidisa/print/left.doc"; // 其他左变更模板默认路径

	private final static String DEPENTRP_DIR = "jsp/cams/bpt/flow/disability/exchacertidisa/print/depright.doc"; // 三属右变更模板默认路径
	
	private final static String WARRP_DIR = "jsp/cams/bpt/flow/disability/exchacertidisa/print/testright.doc"; // 参战右变更模板默认路径
	
	private final static String TESTRP_DIR = "jsp/cams/bpt/flow/disability/exchacertidisa/print/testright.doc"; // 参试右变更模板默认路径
	
	private final static String DEMOBILIZEDRP_DIR = "jsp/cams/bpt/flow/disability/exchacertidisa/print/demillright.doc"; // 带病回乡右变更模板默认路径
	
	private final static String CERTERCHANGERP_DIR = "jsp/cams/bpt/flow/disability/exchacertidisa/print/right.doc"; // 换证补证及证件变更右变更模板默认路径
	
	private final static String CERTERCHANGELP_DIR = "jsp/cams/bpt/flow/disability/exchacertidisa/print/left.doc"; // 换证补证及证件变更左变更模板默认路径
	
	
	
	/**
	 * 查询某行政区划下的优抚打证模板列表
	 * 
	 * @return
	 */
	public DataSet query() {
		ParameterSet pset = getParameterSet();
		String organCode = BspUtil.getOrganCode();
		String fileDomicile = organCode.substring(0, 6);
		pset.setParameter("FILE_DOMICILE", fileDomicile);
		DataSet ds = bptCertTemplatesDomain.query(pset);
		if (ds.getCount() == 0) { // 无模板
			addCertTemplates(fileDomicile); // 默认添加模板
			ds = bptCertTemplatesDomain.query(pset);
		}
		return ds;
	}

	/**
	 * 添加默认模板
	 * 
	 * @param fileDomicile
	 */
	@Trans
	private void addCertTemplates(String fileDomicile) {
		List<BptCertTemplates> lists = new ArrayList<BptCertTemplates>();

		if (!"0000".equals(fileDomicile.substring(2, 6))) { // 不是省级用户
			if ("00".equals(fileDomicile.substring(4, 6))) { // 市级用户
				// 添加在乡模板
				BptCertTemplates domobCert = getBptCertTemplates(fileDomicile);
				domobCert.setServiceType("41");
				domobCert.setFilePath(DEMOBILIZED_DIR);
				domobCert.setFileId(IdHelp.getUUID30());
				domobCert.setFileName(getFileName(DEMOBILIZED_DIR));

				lists.add(domobCert);

				// 添加在乡右变更模板
				BptCertTemplates demrpCert = getBptCertTemplates(fileDomicile);
				demrpCert.setServiceType("65");
				demrpCert.setFilePath(DEMOBILIZEDRP_DIR);
				demrpCert.setFileId(IdHelp.getUUID30());
				demrpCert.setFileName(getFileName(DEMOBILIZEDRP_DIR));

				lists.add(demrpCert);
				
				//添加其他左变更模版
				BptCertTemplates otherlpCert = getBptCertTemplates(fileDomicile);
				otherlpCert.setServiceType("69");
				otherlpCert.setFilePath(OTHERLP_DIR);
				otherlpCert.setFileId(IdHelp.getUUID30());
				otherlpCert.setFileName(getFileName(OTHERLP_DIR));

				lists.add(otherlpCert);
				
				// 添加带病回乡模板
				BptCertTemplates illnessCert = getBptCertTemplates(fileDomicile);
				illnessCert.setServiceType("42");
				illnessCert.setFilePath(DEMOBILIZEDILLNESS_DIR);
				illnessCert.setFileId(IdHelp.getUUID30());
				illnessCert.setFileName(getFileName(DEMOBILIZEDILLNESS_DIR));

				lists.add(illnessCert);

				// 添加带病回乡右变更模板
				BptCertTemplates demillnessCert = getBptCertTemplates(fileDomicile);
				demillnessCert.setServiceType("66");
				demillnessCert.setFilePath(DEMOBILIZEDIllNESSRP_DIR);
				demillnessCert.setFileId(IdHelp.getUUID30());
				demillnessCert.setFileName(getFileName(DEMOBILIZEDIllNESSRP_DIR));

				lists.add(demillnessCert);

				
			} else { // 县级用户
				// 添加三属病故模板
				BptCertTemplates dependBgCert = getBptCertTemplates(fileDomicile);
				dependBgCert.setServiceType("23");
				dependBgCert.setFilePath(DEPENTBG_DIR);
				dependBgCert.setFileId(IdHelp.getUUID30());
				dependBgCert.setFileName(getFileName(DEPENTBG_DIR));

				lists.add(dependBgCert);

				// 添加三属烈士模板
				BptCertTemplates depentLSCert = getBptCertTemplates(fileDomicile);
				depentLSCert.setServiceType("21");
				depentLSCert.setFilePath(DEPENTLS_DIR);
				depentLSCert.setFileId(IdHelp.getUUID30());
				depentLSCert.setFileName(getFileName(DEPENTLS_DIR));

				lists.add(depentLSCert);

				// 添加三属因公模板
				BptCertTemplates depentYGCert = getBptCertTemplates(fileDomicile);
				depentYGCert.setServiceType("22");
				depentYGCert.setFilePath(DEPENTYG_DIR);
				depentYGCert.setFileId(IdHelp.getUUID30());
				depentYGCert.setFileName(getFileName(DEPENTYG_DIR));

				lists.add(depentYGCert);

				// 添加三属右变更模版
				BptCertTemplates depentrpCert = getBptCertTemplates(fileDomicile);
				depentrpCert.setServiceType("62");
				depentrpCert.setFilePath(DEPENTRP_DIR);
				depentrpCert.setFileId(IdHelp.getUUID30());
				depentrpCert.setFileName(getFileName(DEPENTRP_DIR));

				lists.add(depentrpCert);
				
				// 添加参试模板
				BptCertTemplates testCert = getBptCertTemplates(fileDomicile);
				testCert.setServiceType("61");
				testCert.setFilePath(TEST_DIR);
				testCert.setFileId(IdHelp.getUUID30());
				testCert.setFileName(getFileName(TEST_DIR));

				lists.add(testCert);

				// 添加参试右变更模板
				BptCertTemplates testrpCert = getBptCertTemplates(fileDomicile);
				testrpCert.setServiceType("63");
				testrpCert.setFilePath(TESTRP_DIR);
				testrpCert.setFileId(IdHelp.getUUID30());
				testrpCert.setFileName(getFileName(TESTRP_DIR));

				lists.add(testrpCert);

				// 添加参战模板
				BptCertTemplates warCert = getBptCertTemplates(fileDomicile);
				warCert.setServiceType("51");
				warCert.setFilePath(WAR_DIR);
				warCert.setFileId(IdHelp.getUUID30());
				warCert.setFileName(getFileName(WAR_DIR));

				lists.add(warCert);

				// 添加参战右变更模板
				BptCertTemplates warrpCert = getBptCertTemplates(fileDomicile);
				warrpCert.setServiceType("64");
				warrpCert.setFilePath(WARRP_DIR);
				warrpCert.setFileId(IdHelp.getUUID30());
				warrpCert.setFileName(getFileName(WARRP_DIR));

				lists.add(warrpCert);
			}
			
			//添加其他左变更模版
			BptCertTemplates otherlpCert = getBptCertTemplates(fileDomicile);
			otherlpCert.setServiceType("69");
			otherlpCert.setFilePath(OTHERLP_DIR);
			otherlpCert.setFileId(IdHelp.getUUID30());
			otherlpCert.setFileName(getFileName(OTHERLP_DIR));

			lists.add(otherlpCert);
		} else { //省级用户
			// 添加残疾军人模板
			BptCertTemplates disablityJRCert = getBptCertTemplates(fileDomicile);
			disablityJRCert.setServiceType("11");
			disablityJRCert.setFilePath(DISABLILYJR_DIR);
			disablityJRCert.setFileId(IdHelp.getUUID30());
			disablityJRCert.setFileName(getFileName(DISABLILYJR_DIR));
			lists.add(disablityJRCert);
			
			// 添加伤残人民警察模板
			BptCertTemplates disablityJCCert = getBptCertTemplates(fileDomicile);
			disablityJCCert.setServiceType("13");
			disablityJCCert.setFilePath(DISABLILYJC_DIR);
			disablityJCCert.setFileId(IdHelp.getUUID30());
			disablityJCCert.setFileName(getFileName(DISABLILYJC_DIR));
			lists.add(disablityJCCert);
			
			// 添加伤残国家机关工作人员模板
			BptCertTemplates disablityGZCert = getBptCertTemplates(fileDomicile);
			disablityGZCert.setServiceType("12");
			disablityGZCert.setFilePath(DISABLILYGZ_DIR);
			disablityGZCert.setFileId(IdHelp.getUUID30());
			disablityGZCert.setFileName(getFileName(DISABLILYGZ_DIR));
			lists.add(disablityGZCert);
			
			// 添加伤残民兵民工模板
			BptCertTemplates disabilityMBCert = getBptCertTemplates(fileDomicile);
			disabilityMBCert.setServiceType("14");
			disabilityMBCert.setFilePath(DISABLILYMB_DIR);
			disabilityMBCert.setFileId(IdHelp.getUUID30());
			disabilityMBCert.setFileName(getFileName(DISABLILYMB_DIR));
			lists.add(disabilityMBCert);
			//伤残左变更模版
			BptCertTemplates dislpCert = getBptCertTemplates(fileDomicile);
			dislpCert.setServiceType("68");
			dislpCert.setFilePath(DISABILITYLP_DIR);
			dislpCert.setFileId(IdHelp.getUUID30());
			dislpCert.setFileName(getFileName(DISABILITYLP_DIR));

			lists.add(dislpCert);
			
			// 添加残疾军人右变更模板
			BptCertTemplates disablityrpCert = getBptCertTemplates(fileDomicile);
			disablityrpCert.setServiceType("67");
			disablityrpCert.setFilePath(DISABILITYRP_DIR);
			disablityrpCert.setFileId(IdHelp.getUUID30());
			disablityrpCert.setFileName(getFileName(DISABILITYRP_DIR));
			lists.add(disablityrpCert);
			// 换证补证右变更模板
			BptCertTemplates changerpCert = getBptCertTemplates(fileDomicile);
			changerpCert.setServiceType("70");
			changerpCert.setFilePath(CERTERCHANGERP_DIR);
			changerpCert.setFileId(IdHelp.getUUID30());
			changerpCert.setFileName(getFileName(CERTERCHANGERP_DIR));
			lists.add(changerpCert);
			// 换证补证左变更模板
			BptCertTemplates changelpCert = getBptCertTemplates(fileDomicile);
			changelpCert.setServiceType("71");
			changelpCert.setFilePath(CERTERCHANGELP_DIR);
			changelpCert.setFileId(IdHelp.getUUID30());
			changelpCert.setFileName(getFileName(CERTERCHANGELP_DIR));
			lists.add(changelpCert);
		}
		bptCertTemplatesDomain.insert(lists);
	}

	/**
	 * 通过模板路径取得文件名
	 * 
	 * @param path
	 * @return
	 */
	private String getFileName(String path) {
		return path.substring(path.lastIndexOf("/") + 1);
	}

	/**
	 * 创建初始化模板
	 * 
	 * @param fileDomicile
	 * @return
	 */
	private BptCertTemplates getBptCertTemplates(String fileDomicile) {
		BptCertTemplates bptCertTemplates = new BptCertTemplates();
		bptCertTemplates.setModTime(DateUtil.getDay());
		bptCertTemplates.setFileDomicile(fileDomicile);
		bptCertTemplates.setIsDefault("1"); // 设为默认模板
		return bptCertTemplates;
	}

}
