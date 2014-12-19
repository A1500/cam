package com.inspur.cams.drel.sam.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.sam.domain.ISamApplyInfoDomain;

/**
 * @title:申请审批信息查询Cmd
 * @description:
 * @author:	yanliangliang
 * @since:2012-05-02
 * @version:1.0
*/
public class SamApplyInfoQueryCmd extends BaseQueryCommand{
	private ISamApplyInfoDomain samApplyInfoDomain = ScaComponentFactory.getService(ISamApplyInfoDomain.class, "samApplyInfoDomain/samApplyInfoDomain");
	
	@SuppressWarnings("unchecked")
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return samApplyInfoDomain.query(pset);
	}
	/**
	 * 获取一条家庭和待遇信息关联的家庭信息
	 * @param FAMILY_ID
	 */
	public DataSet getSamFamily(){
		ParameterSet pset = getParameterSet();
		return samApplyInfoDomain.getSamFamily(pset);
	}
	/**
	 * 查询待办
	 * @param processType 流程类型
	 * @param actDefName 环节名称
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryDaiBan(){
		ParameterSet pset = getParameterSet();
		return samApplyInfoDomain.queryDaiBan(pset);
	}
	
	
	/**
	 * 查询待办
	 * @param processType 流程类型
	 * @param actDefName 环节名称
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryExport(){
		ParameterSet pset = getParameterSet();
		return samApplyInfoDomain.queryExport(pset);
	}
	
	
	/**
	 * 查询已办
	 * @param processType 流程类型
	 * @param actDefName 环节名称
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryYiBan(){
		ParameterSet pset = getParameterSet();
		return samApplyInfoDomain.queryYiBan(pset);
	}
	/**
	 * 查询结束
	 * @param processType 流程类型
	 * @param actDefName 环节名称
	 * @return
	 */
	public DataSet queryJieShu(){
		ParameterSet pset = getParameterSet();
		return samApplyInfoDomain.queryEnd(pset);
	}
	/**
	 * 查询历史
	 */
	public DataSet queryHis(){
		ParameterSet pset = getParameterSet();
		return samApplyInfoDomain.queryHis(pset);
	}
	
	/**
	 * 查询变更公示打印数据
	 * @return
	 */
	public DataSet queryNoticePrintData(){
		ParameterSet pset = getParameterSet();
		return samApplyInfoDomain.queryNoticePrintData(pset);
	}
	
	 public DataSet queryRecheckToChange(){
    	ParameterSet pset = getParameterSet();
    	return samApplyInfoDomain.queryRecheckToChange(pset);
    }
	 
	 public  DataSet queryForExportPeople(){
		ParameterSet pset = getParameterSet();
		return samApplyInfoDomain.queryForExportPeople(pset);
	}
	 
	 public  DataSet queryForPeopleDetail(){
	 	ParameterSet pset = getParameterSet();
		return samApplyInfoDomain.queryForPeopleDetail(pset);
	}
	 
	 public  DataSet queryInTheWarranty(){
	 ParameterSet pset = getParameterSet();
		return samApplyInfoDomain.queryInTheWarranty(pset);
	}
	 
	 
	 public  DataSet queryInAssitanceDetail(){
	 ParameterSet pset = getParameterSet();
		return samApplyInfoDomain.queryInAssitanceDetail(pset);
	}

}
