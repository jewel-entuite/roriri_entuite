<cfcomponent output="false" hint="Pagination Component">

    <!-- Row Count Dropdown -->
    <cffunction name="RowCount" returntype="any">
        <cfsavecontent variable="rowCountContent">
                <div class="d-flex align-items-center pl-5" style="height: 42px;">
                    <select id="rowCount" class="form-control form-control-lg select-default" onchange="changeRowCount()">
                        <option value="10">10</option>
                        <option selected value="20">20</option>
                        <option value="50">50</option>
                        <option value="100">100</option>
                        <option value="500">500</option>
                    </select>
                </div>
        </cfsavecontent>
        <cfreturn rowCountContent />
    </cffunction>

    <!-- Go to Page Input -->
    <cffunction name="GoToPagination" returntype="any">
        <cfsavecontent variable="goToPaginationContent">
            <div class="d-flex align-items-center mb-3" style="height: 34px; padding-left: 18px;">
                <input id="goToPageInput" type="text" class="form-control form-control-sm me-2" 
                     min="1" style="width: 50px; padding: 5.5px 0.75rem; font-size: 0.875rem; line-height: 1.5;" />
                <button class="btn btn-sm btn-light page-link" style="height: 34px; font-size: 13px; line-height: 1.5; padding: 7.5px 0.75rem;" onclick="goToPagination()">Go</button>
            </div>
        </cfsavecontent>
        <cfreturn goToPaginationContent />
    </cffunction>

    <!-- Total Record Count and Page Info -->
    <cffunction name="PageInfo" returntype="any">
        <cfsavecontent variable="pageInfoContent">
            <div id="pagination-info" class="text-muted" style="height: 42px; padding-top: 4px; padding-left:2px;">
                Placeholder for page and total record info
            </div>
        </cfsavecontent>
        <cfreturn pageInfoContent />
    </cffunction>

    <!-- Pagination Controls -->
    <cffunction name="Pagination" returntype="any">
        <cfsavecontent variable="paginationContent">
            <nav aria-label="Page navigation" style="padding-left: 18px;height: 42px;">
                <ul id="pagination-controls" class="pagination justify-content-end" style="height: 36px; font-size: 0.875rem; line-height: 1.5; padding: 0;"></ul>
            </nav>
        </cfsavecontent>
        <cfreturn paginationContent />
    </cffunction>

    <!-- Pagination Script -->
    <cffunction name="PaginationScript" returntype="any">
        <cfargument name="tableId" type="string" required="false" />
        <cfsavecontent variable="paginationScript">
            <script>
                let pageSize = 10; // Default number of records per page
                let currentPage = 1;
                const rows = document.querySelectorAll("#<cfoutput>#arguments.tableId#</cfoutput> tbody tr");
                const totalRows = rows.length;
                let totalPages = Math.ceil(totalRows / pageSize);

            // Function to display a specific page
            function showPage(page) {
                if (page < 1 || page > totalPages) return; // Ensure valid page number
                currentPage = page;

                const start = (page - 1) * pageSize;
                const end = page * pageSize;

                // Hide all rows, then display the rows for the selected page
                rows.forEach((row, index) => {
                    row.style.display = index >= start && index < end ? '' : 'none';
                });

                updatePaginationControls();
                updatePageInfo(); // Update page and record count
            }

            // Update pagination controls (buttons)
            function updatePaginationControls() {
                const paginationContainer = document.getElementById("pagination-controls");
                paginationContainer.innerHTML = '';

                // Previous Button
                const prevButton = document.createElement("li");
                prevButton.classList.add("page-item");
                if (currentPage === 1) prevButton.classList.add("disabled");
                prevButton.innerHTML = `<a class="page-link" href="javascript:void(0);" onclick="previousPage()">Previous</a>`;
                paginationContainer.appendChild(prevButton);

                // Calculate the start and end page for the visible range
                let startPage = Math.max(1, currentPage - 2);
                let endPage = Math.min(totalPages, currentPage + 2);

                // Add first page button if needed
                if (startPage > 1) {
                    const firstPageItem = document.createElement("li");
                    firstPageItem.classList.add("page-item");
                    firstPageItem.innerHTML = `<a class="page-link" href="javascript:void(0);" onclick="showPage(1)">1</a>`;
                    paginationContainer.appendChild(firstPageItem);

                    // Show ellipsis if there are skipped pages before
                    const ellipsisBefore = document.createElement("li");
                    ellipsisBefore.classList.add("page-item");
                    ellipsisBefore.innerHTML = `<span class="page-link">...</span>`;
                    paginationContainer.appendChild(ellipsisBefore);
                }

                // Add page numbers for the visible range
                for (let i = startPage; i <= endPage; i++) {
                    const pageItem = document.createElement("li");
                    pageItem.classList.add("page-item");
                    if (i === currentPage) pageItem.classList.add("active");
                    pageItem.innerHTML = `<a class="page-link" href="javascript:void(0);" onclick="showPage(${i})">${i}</a>`;
                    paginationContainer.appendChild(pageItem);
                }

                // Add last page button if needed
                if (endPage < totalPages) {
                    const ellipsisAfter = document.createElement("li");
                    ellipsisAfter.classList.add("page-item");
                    ellipsisAfter.innerHTML = `<span class="page-link">...</span>`;
                    paginationContainer.appendChild(ellipsisAfter);

                    const lastPageItem = document.createElement("li");
                    lastPageItem.classList.add("page-item");
                    lastPageItem.innerHTML = `<a class="page-link" href="javascript:void(0);" onclick="showPage(${totalPages})">${totalPages}</a>`;
                    paginationContainer.appendChild(lastPageItem);
                }

                // Next Button
                const nextButton = document.createElement("li");
                nextButton.classList.add("page-item");
                if (currentPage === totalPages) nextButton.classList.add("disabled");
                nextButton.innerHTML = `<a class="page-link" href="javascript:void(0);" onclick="nextPage()">Next</a>`;
                paginationContainer.appendChild(nextButton);
            }

            // Update total records and page info
            function updatePageInfo() {
                const paginationInfo = document.getElementById("pagination-info");
                paginationInfo.textContent = `Page ${currentPage} of ${totalPages} - Total Records: ${totalRows }`;
            }

            // Change the number of rows per page
            function changeRowCount() {
                const rowCountSelect = document.getElementById("rowCount");
                pageSize = parseInt(rowCountSelect.value, 10);
                totalPages = Math.ceil(totalRows / pageSize);
                currentPage = 1; // Reset to the first page
                showPage(currentPage);
            }

            // Go to a specific page
            function goToPagination() {
                const pageInput = document.getElementById("goToPageInput");
                let pageNumber = parseInt(pageInput.value, 10); // Convert input to a number

                // Validate the input page number
                if (isNaN(pageNumber)) {
                    alert("Please enter a valid number for the page.");
                    return;
                }

                if (pageNumber < 1 || pageNumber > totalPages) {
                    alert(`Please enter a valid page number between 1 and ${totalPages}.`);
                    return;
                }

                // If the input is valid, navigate to the specified page
                showPage(pageNumber);

                // Reset the input field after navigating
                pageInput.value = "";
            }


            // Navigate to the next page
            function nextPage() {
                if (currentPage < totalPages) {
                    showPage(currentPage + 1);
                }
            }

            // Navigate to the previous page
            function previousPage() {
                if (currentPage > 1) {
                    showPage(currentPage - 1);
                }
            }

            // Initialize by displaying the first page
            showPage(currentPage);

                        </script>
                    </cfsavecontent>
                    <cfreturn paginationScript />
    </cffunction>

</cfcomponent>
