package com.inspur.cams.prs.prsretiredsoldiers.cmd;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.loushang.bsp.security.context.GetBspInfo;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.upload.MultipartRequestWrapper;
import org.loushang.next.upload.UploadFile;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.CamsProperties;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.prs.prsretiredsoldiers.dao.SoldiersUpload;
import com.inspur.cams.prs.prsretiredsoldiers.dao.SoldiersuploadDao;

/**
 * @title:SoldiersuploadCommand
 * @description:
 * @author:
 * @since:2011-12-06
 * @version:1.0
*/
public class SoldiersuploadCommand extends BaseAjaxCommand{
	private SoldiersuploadDao dao = (SoldiersuploadDao) DaoFactory
			.getDao("com.inspur.cams.prs.prsretiredsoldiers.dao.SoldiersuploadDao");
	private static final String file_dir = CamsProperties.getString("file_dir");
	@Trans
	public void insert() {
		Record record = (Record) getParameter("record");
		SoldiersUpload dataBean=(SoldiersUpload)record.toBean(SoldiersUpload.class);
		MultipartRequestWrapper wrapRequest = (MultipartRequestWrapper) getRequest();// 获取包装后的request
		UploadFile uploadFile = wrapRequest.getUploadFile("catalogName"); 
		String organCode = BspUtil.getOrganCode();
		String file_domicode = organCode.substring(0, 6); //取行政区划前六位
		String pathDir = file_dir  + file_domicode;// 路径
		File file = new File(pathDir);
		if (!file.exists()) { // 创建上传目录
			file.mkdirs();
		}
		String catalogId = IdHelp.getUUID32(); // 模板文件数据库主键
		
		
		
		//String catalogName = dataBean.getCatalogName();
		//String catalog_name=uploadFile.getFileName();
		String catalog_name=dataBean.getCatalogCode()+"."+uploadFile.getFileName().substring(uploadFile.getFileName().lastIndexOf(".")+1);
		String username=GetBspInfo.getBspInfo(getRequest()).getUserName();
		String filePath = pathDir + "/" + catalogId+ catalog_name; // 路径名称
		
		
		dataBean.setCatalogId(catalogId);
		//String organName=BspUtil.getOrganName();
		dataBean.setFileOper(username);
		dataBean.setInsertFlag("0");
		dataBean.setFilePath(filePath);
		file = new File(filePath);
		byte[] buffer = new byte[1024 * 10];
		FileOutputStream out = null;
		InputStream in = null;
		int size = 0;
		try {
			out = new FileOutputStream(file);
			in = uploadFile.getInputStream();
			while ((size = in.read(buffer)) != -1) {
				out.write(buffer,0,size);
				out.flush();
			}
			
			dataBean.setCatalogName(catalog_name);
			dataBean.setFilePath(filePath);
			dataBean.setUploadTime(DateUtil.getDay());
			dao.insert(dataBean);

		} catch (IOException e) {
			e.printStackTrace();
		} finally { //关闭流
			if (null != in) {
				try {
					in.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if (null != out) {
				try {
					out.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}

		}
		//setReturn("catalogId", catalogId);
		setReturn("filepath", filePath);
	//	setReturn("cataname", catalog_name);
	}
	@Trans
	public void update() {
		Record record = (Record) getParameter("record");
		SoldiersUpload dataBean=(SoldiersUpload)record.toBean(SoldiersUpload.class);
		dao.update(dataBean);
	}
	@Trans
	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	@Trans
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SoldiersUpload> list = new ArrayList<SoldiersUpload>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SoldiersUpload dataBean = (SoldiersUpload) records[i].toBean(SoldiersUpload.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
	//更改是否导入标识及导入数量
	@Trans
	public void updateFlag(){
		Integer count = (Integer) getParameter("count");
		String id = (String) getParameter("id");
		SoldiersUpload databean = dao.get(id);
		if(count != null){
			databean.setContain_num(count);
		}
		databean.setInsertFlag("1");
		dao.update(databean);
	}
	
}
