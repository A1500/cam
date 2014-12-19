package com.inspur.cams.bpt.manage.cmd;

import java.util.ArrayList;
import java.util.List;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.comm.util.BspUtil;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.edoc.dao.jdbc.BptCatalogueArchivesDao;
import com.inspur.cams.bpt.edoc.data.BptCatalogueArchives;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;

/**
 * @title:BptCatalogueArchivesSaveCommand
 * @description:
 * @author:
 * @since:2011-05-19
 * @version:1.0
 */
public class BptCatalogueArchivesSaveCommand extends BaseAjaxCommand {
	private BptCatalogueArchivesDao dao = (BptCatalogueArchivesDao) DaoFactory.getDao("com.inspur.cams.bpt.edoc.dao.jdbc.BptCatalogueArchivesDao");
	IBptGroupDomain service = ScaComponentFactory.getService(IBptGroupDomain.class, "bptGroupDomain/bptGroupDomain");
	@Trans
	public void save() {
		Record BptCatalogueArchivesrec = (Record) getParameter("bptCatalogueArchivesRecord");
		String parentId = (String) getParameter("parentId");
		//String childId = (String) getParameter("childId");
		String organId = BspUtil.getOrganCode();
		BptCatalogueArchives databean = (BptCatalogueArchives) BptCatalogueArchivesrec.toBean(BptCatalogueArchives.class);
		databean.setUpCatalogCode(parentId);
		databean.setCatalogCode(IdHelp.getUUID32());
		databean.setCatalogID(IdHelp.getUUID30());
		databean.setOrganId(organId);
		if(databean.getLeve().equals("")){
		   databean.setLeve("1");
		}else{
		   databean.setLeve("2");
		}
		List list = new ArrayList();
		list.add(databean);
		dao.save(list);
	}
	@Trans
	public void delete() {
		String delId = (String) getParameter("delId");
		service.deleteCatalogueArchives(delId);

	}
	@Trans
	public void deleteAll() {

		dao.deleteStruAll();
	}
    
	/**
	 * 
	 * 更新节点信息
	 */
	@Trans
	public void update() {
		Record BptCatalogueArchivesrec = (Record) getParameter("bptCatalogueArchivesRecord");
		String parentId = (String) getParameter("parentId");
		String childId = (String) getParameter("childId");
		String organId = BspUtil.getOrganCode();
		BptCatalogueArchives databean = (BptCatalogueArchives) BptCatalogueArchivesrec.toBean(BptCatalogueArchives.class);
		databean.setUpCatalogCode(parentId);
		databean.setCatalogCode(childId);
		databean.setOrganId(organId);
		databean.setOrganId(organId);
		dao.update(databean);
	}
    
	/**
	 * 
	 * 检查当前organCode所属区县是否已有优抚目录结构树
	 */
	public void checkReturn(){
		ParameterSet pset = new ParameterSet();
		String organId = BspUtil.getOrganCode();
		pset.setParameter("ORGAN_ID", organId);
		DataSet ds = dao.query(pset);
		if(ds.getCount()!=0){
			this.setReturn("flag", "1");
		}else{
			this.setReturn("flag", "0");
		}
	}
	
	/**
	 * 
	 * 检查在同一organCode中是否存在相同的catalogCode
	 */
	public void getFlag(){
		ParameterSet pset =this.getParameterSet();
		ParameterSet param = new ParameterSet();
		param.setParameter("catalogCode", pset.getParameter("catalogCode"));
		param.setParameter("organCode", BspUtil.getOrganCode());
		DataSet ds =dao.getFlag(param);
		if(ds.getCount()!=0){
			this.setReturn("flag", "1");
		}else{
			this.setReturn("flag", "0");
		}
	}
	/**
	 * 
	 * 
	 * 根据当前的organCode保存民政厅基本优抚目录树结构
	 */
	@Trans
	public void saveTree() {
		ParameterSet pset = this.getParameterSet();
		String organId = BspUtil.getOrganCode();
		pset.setParameter("ORGAN_ID", "370000000000");
		DataSet ds = dao.query(pset);//
		List list = new ArrayList();
		if (ds.getCount() != 0) {
			for (int i = 0; i < ds.getCount(); i++) {
				BptCatalogueArchives databean = (BptCatalogueArchives) ds.getRecord(i).toBean(BptCatalogueArchives.class);
				databean.setCatalogID(IdHelp.getUUID30());
                databean.setOrganId(organId);
				list.add(databean);
			}
			dao.batchInsert(list);
		}
		
	}
}
